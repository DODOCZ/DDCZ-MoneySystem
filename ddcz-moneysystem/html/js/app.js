// Zavření UI
function closeExchange() {
    fetch(`https://${GetParentResourceName()}/closeExchange`, {
        method: 'POST'
    });
    document.querySelector('.exchange-container').style.display = 'none';
    SetNuiFocus(false, false);
}

// Funkce pro směnu
function exchange(from, to) {
    const amount = prompt(`Zadejte částku pro směnu (${from} → ${to}):`);
    if (amount && !isNaN(amount) && amount > 0) {
        fetch(`https://${GetParentResourceName()}/exchange`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json; charset=UTF-8'
            },
            body: JSON.stringify({
                from: from,
                to: to,
                amount: amount
            })
        });
    } else {
        alert("Neplatná částka!");
    }
}

// Poslouchání zpráv od Lua
window.addEventListener('message', (event) => {
    const data = event.data;
    
    if (data.type === "showExchange") {
        document.querySelector('.exchange-container').style.display = 'block';
    } else if (data.type === "hideExchange") {
        document.querySelector('.exchange-container').style.display = 'none';
    }
});