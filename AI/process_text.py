from flask import Flask, request, jsonify
import cv2
import google.generativeai as genai
from image_to_text import OCRReader  # Import the OCRReader class

# Configure Google Generative AI
genai.configure(api_key="AIzaSyD5ZOieaUhjmA0yJYWt7vgrpapKChzUHm0")

# Initialize Flask app
app = Flask(__name__)

def get_detected_texts(image_path):
    """
    Use OCRReader to extract and return detected texts from an image.
    """
    ocr_reader = OCRReader(image_path)  # Initialize OCRReader
    detected_texts = ocr_reader.read_text()  # Extract text
    return detected_texts


def get_annotated_image(image_path):
    """
    Use OCRReader to annotate the image with bounding boxes and detected texts.
    """
    ocr_reader = OCRReader(image_path)  # Initialize OCRReader
    ocr_reader.read_text()  # Perform text detection
    annotated_image = ocr_reader.annotate_image()  # Annotate the image
    return annotated_image


def get_ai_response(text):
    """
    Generate a response from Google Generative AI based on the input text.
    """
    generation_config = {
        "temperature": 0.9,
        "top_p": 1,
        "top_k": 1,
        "max_output_tokens": 2048
    }
    model = genai.GenerativeModel("gemini-1.5-flash", generation_config=generation_config)
    convo = model.start_chat(
        history=[
            {
                "role": "user",
                "parts": [
                    "I will be providing an array of text consisting of a business card details for you to assess. "
                    "Assess the string of arrays and get the 'Full name', 'Company name', 'email', 'phone number', and 'website'. "
                    "ONLY return a JSON format for each (don't include asterisk or any kind. JUST THE JSON). "
                    "If you can't assess which parameter is not present in the context, make as 'N/A'."
                    "Fix the email address if it's not a valid email address."
                    "Make the phone number in a format of '+00 000 000 0000'."
                ]
            }
        ]
    )
    response = convo.send_message(text)
    return response.text


@app.route('/process-image', methods=['POST'])
def process_image():
    try:
        # Check if image file exists
        image_file = request.files.get('image')
        if not image_file:
            return jsonify({'error': 'No image file received'}), 400

        # Save the image
        image_path = "uploaded_image.jpg"
        image_file.save(image_path)

        # Process the image
        ocr_reader = OCRReader(image_path)
        detected_texts = ocr_reader.read_text()
        annotated_image = ocr_reader.annotate_image()

        # Generate AI response
        ai_response = get_ai_response(detected_texts)

        # Return results
        return jsonify({
            'detected_texts': detected_texts,
            'ai_response': ai_response
        })

    except Exception as e:
        print(f"Server Error: {e}")
        return jsonify({'error': 'Server encountered an error'}), 500

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=5000)
