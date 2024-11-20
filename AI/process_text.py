import cv2
import google.generativeai as genai
from image_to_text import OCRReader  # Import the OCRReader class

genai.configure(api_key="AIzaSyD5ZOieaUhjmA0yJYWt7vgrpapKChzUHm0")

def get_detected_texts(image_path):
    """
    Use OCRReader to extract and return detected texts from an image.
    """
    ocr_reader = OCRReader(image_path)  # Initialize OCRReader
    detected_texts = ocr_reader.read_text()  # Extract text
    detected_texts = str(detected_texts)
    print("Detected Texts:", detected_texts)  # Print detected texts
    return detected_texts


def get_annotated_image(image_path):
    """
    Use OCRReader to annotate the image with bounding boxes and detected texts.
    """
    ocr_reader = OCRReader(image_path)  # Initialize OCRReader
    ocr_reader.read_text()  # Perform text detection
    annotated_image = ocr_reader.annotate_image()  # Annotate the image

    # Save the annotated image
    annotated_image_path = "annotated_image.jpg"
    # cv2.imwrite(annotated_image_path, annotated_image)
    # print(f"Annotated image saved to {annotated_image_path}")
    print(type(annotated_image))
    return annotated_image

def get_ai_response(text):
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
                "parts": ["I will be providing an array of text consisting of a business card details for you to assess. Assess the string of arrays and get the 'Full name', 'Company name', 'email', 'phone number', and 'website'. ONLY return a JSON format for each(don't inlude asterisk or anykind. JUST THE JSON). If you can't assess which parameter is not present in the context, make as 'N/A'. Also, complete the "]
            },
            {
                "role": "model",
                "parts": ["{"
                          " 'full_name': 'Israel F. Breta',"
                          " 'company_name': 'Stappl Inc.',"
                          " 'email': 'ismabreta@gmail.com',"
                          " 'contact_number': '+63 998 356 6406',"
                          " 'website': 'N/A'"
                          "}"]
            }
        ]
    )

    response = convo.send_message(text)
    return response.text

# Example usage
if __name__ == "__main__":
    image_path = "data/2.jpg"  # Path to your image

    # Get detected texts
    texts = get_detected_texts(image_path)
    gen_ai_response = get_ai_response(texts)
    print(gen_ai_response)

    # Get annotated image
    # annotated_img = get_annotated_image(image_path)
