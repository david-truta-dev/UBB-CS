

function specialLeft(e){
    const row = $($(e).parent()[0]).parent()[0]
    const table = $(row).parent()[0]
    console.log('left', row)
    $(row).remove()
    table.innerHTML = ('<p>invisible</p>') + table.innerHTML
}

function checkAllRows(cells){
    for(let i=1;i<6;i++){
        if($(cells[i]).children()[0].value === '')
            return false
    }
    return true
}

function makeReadOnly(e){
    const row = $($(e).parent()[0]).parent()[0]
    if(checkAllRows(row.cells))  
        for(let i=1;i<6;i++){
            row.cells[i].innerHTML = $(row.cells[i]).children()[0].value
        }
}

function specialRight(e){
    const row = $($(e).parent()[0]).parent()[0]
    const table = $($(row).parent()[0]).parent()[0]
    console.log(table)
    let index=1
    for (r of table.rows){
        if (row === r)
            break
        index++
    }
    const newRow = table.insertRow(index)
    const c1 = newRow.insertCell(0);c1.innerHTML = '<button onclick="specialLeft(this)"></button>'
    const c2 = newRow.insertCell(1);c2.innerHTML = '<input type="text" onblur="makeReadOnly(this)"/>'
    const c3 = newRow.insertCell(2);c3.innerHTML = '<input type="text" onblur="makeReadOnly(this)"/>'
    const c4 = newRow.insertCell(3);c4.innerHTML = '<input type="text" onblur="makeReadOnly(this)"/>'
    const c5 = newRow.insertCell(4);c5.innerHTML = '<input type="text" onblur="makeReadOnly(this)"/>'
    const c6 = newRow.insertCell(5);c6.innerHTML = '<input type="text" onblur="makeReadOnly(this)"/>'
    const c7 = newRow.insertCell(6);c7.innerHTML = '<button onclick="specialRight(this)"></button>'
}