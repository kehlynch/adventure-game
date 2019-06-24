export default function questionType() {
  const questionOptions = document.querySelector(".question-template-options");
  const questionMinMax = document.querySelector(".question-template-min-max");
  const ratingQuestionLinks = document.querySelector(".rating-question-links");
  const questionPlaceholderText = document.querySelector(".question-template-placeholder-text");

  const virtualTypeSelect = document.querySelector(".virtual-type-select");

  if (virtualTypeSelect) {
    virtualTypeSelect.addEventListener("change", () => {
      const virtualType = virtualTypeSelect.value;

      // Show 'Options' field when question type is 'Single Select' or 'Multi Select'
      // but hide if another question type is selected
      if (virtualType === "Multi Select" || virtualType === "Single Select") {
        questionOptions.classList.add("show-options");
      } else {
        questionOptions.classList.remove("show-options");
      }

      // Show 'Min/Max Options' fields when question type is 'Multi Select'
      // but hide if another question type is selected
      if (virtualType === "Multi Select") {
        questionMinMax.classList.add("show-min-max");
      } else {
        questionMinMax.classList.remove("show-min-max");
      }

      // Show 'Question Links' field when question type is 'Rating'
      // but hide if another question type is selected
      if (virtualType === "Rating") {
        ratingQuestionLinks.classList.add("show-rating-links");
      } else {
        ratingQuestionLinks.classList.remove("show-rating-links");
      }

      // Show 'Placeholder Text' field when question type is 'Multi Select' or 'Text'
      // but hide if another question type is selected
      if (virtualType === "Multi Select" || virtualType === "Text") {
        questionPlaceholderText.classList.add("show-placeholder-text");
      } else {
        questionPlaceholderText.classList.remove("show-placeholder-text");
      }

      // Change 'Placeholder Text' placeholder text 
      const placeholderTextInput = questionPlaceholderText.querySelector(".placeholder-text-input")
      if (virtualType === "Multi Select") {
        placeholderTextInput.placeholder = 'If left blank, "Add more detail" will be the default label'
      } else if (virtualType === "Text") {
        placeholderTextInput.placeholder = 'If left blank, "Answer..." will be the default label'
      }

      // Show 'Question Links' field for options when question type is 'Single Select'
      // but hide if another question type is selected
      //
      // optionQuestionLinks to be queried each time because they can be added and deleted
      // by other running Javascript
      const optionQuestionLinks = document.querySelectorAll(".option-question-link");
      Array.from(optionQuestionLinks).forEach(field => {
        if (virtualType === "Single Select") {
          field.classList.add("show-option-links");
        } else {
          field.classList.remove("show-option-links");
        }
      })

    });
  }
}
