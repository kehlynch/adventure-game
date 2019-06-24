export default function questionOptions() {
  questionOptions = document.querySelector(".question-template-options");
  if (questionOptions) {
    const addOptionButton = document.querySelector(".add-option-button");
    addOptionButton.addEventListener("click", () => {
      addOption();
    });

    const deleteOptionButtons = document.querySelectorAll(".delete-option-button");
    Array.from(deleteOptionButtons).forEach(deleteOptionButton => {
      deleteOptionButton.addEventListener("click", () => {
        deleteOption(deleteOptionButton);
      });
    })
  }
}

function addOption() {
  const questionOptionsInputs = document.querySelector(".question-template-options-inputs");
  // dummy is always the first input
  const dummyQuestionOptionGroup = document.querySelector(".question-template-option-group");
  const newQuestionOptionGroup = dummyQuestionOptionGroup.cloneNode(true);
  newQuestionOptionGroup.classList.remove("hidden");
  newQuestionOptionGroup.querySelector(".question-template-option").name = "question_template[options][]";
  newQuestionOptionGroup.querySelector(".option-question-link").name = "question_template[option_question_links][]";
  const deleteButton = newQuestionOptionGroup.querySelector(".delete-option-button");
  deleteButton.addEventListener("click", () => {
    deleteOption(deleteButton);
  })
  questionOptionsInputs.appendChild(newQuestionOptionGroup);
}

function deleteOption(button) {
  button.parentElement.remove()
}
