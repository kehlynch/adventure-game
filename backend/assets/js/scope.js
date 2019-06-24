export default function scope() {
  const scope = document.querySelector(".question-template-scope");
  const rolesForm = document.querySelector(".roles-form");
  const questionTextHelpText = document.querySelector(".question-text-help-text")

  if (scope) {
    const followOnOptions = scope.querySelectorAll("input[type=radio][name=\"question_template[scope]\"]");
    Array.from(followOnOptions).forEach(followOnOption => {
      followOnOption.addEventListener("change", () => {
        const userOption = scope.querySelector("input[type=radio][name=\"question_template[scope]\"][value=\"User\"]");

        if (userOption.checked) {
          rolesForm.classList.remove("show-roles-form");
          questionTextHelpText.innerHTML = "Use {insertion} and/or {extra_insertion} to pull the relevant details in to the question"
        } else {
          rolesForm.classList.add("show-roles-form");
          questionTextHelpText.innerHTML = "Use {organisation_name}, {category_name}, {insertion} and/or {extra_insertion} to pull the relevant details in to the question"
        }
      });
    });
  }
}
