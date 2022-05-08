

const textBox = document.getElementById('txtBox')
const selectBox = document.getElementById('selectBox')
textBox.addEventListener('input', editList);
textBox.value = selectBox.value

function insertInput(){
    textBox.value = selectBox.value
    textBox.innerHTML = selectBox.value
    editList()
}

function editList(){
    selectBox.options[selectBox.selectedIndex].value = textBox.value
    selectBox.options[selectBox.selectedIndex].innerHTML = textBox.value
}