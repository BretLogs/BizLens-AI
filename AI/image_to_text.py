import easyocr
import cv2
from matplotlib import pyplot as plt

class OCRReader:
    def __init__(self, image_path, language=['en'], use_gpu=False):
        self.image_path = image_path
        self.language = language
        self.use_gpu = use_gpu
        self.reader = easyocr.Reader(self.language, gpu=self.use_gpu)
        self.image = cv2.imread(self.image_path)
        self.results = None

    def read_text(self):
        """
        Perform text detection on the image and store the results.
        """
        self.results = self.reader.readtext(self.image_path)
        return [detection[1] for detection in self.results]  # Return only detected text

    def annotate_image(self):
        """
        Draw bounding boxes and detected text on the image.
        """
        if self.results is None:
            raise ValueError("No results found. Run `read_text` method first.")
        
        annotated_image = self.image.copy()
        for detection in self.results:
            top_left = tuple([int(val) for val in detection[0][0]])
            bottom_right = tuple([int(val) for val in detection[0][2]])
            text = detection[1]
            # Draw rectangle and text
            cv2.rectangle(annotated_image, top_left, bottom_right, (0, 255, 0), 2)
        return annotated_image

# Example usage
# if __name__ == "__main__":
#     image_path = "data/Front - Israel.jpg"
#     ocr_reader = OCRReader(image_path)
    
#     # Perform text detection
#     detected_texts = ocr_reader.read_text()
    
#     # Annotate the image
#     annotated_img = ocr_reader.annotate_image()
    
#     # Return detected texts and annotated image
#     result = {
#         "texts": detected_texts,
#         "annotated_image": annotated_img
#     }