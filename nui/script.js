$(document).ready(function() {
    window.addEventListener('message', (event) => {
        const data = event.data;

        if (data.type == 'vehiclehud') {
            document.getElementById('speed-output').textContent = data.speed;
            document.getElementById('gear-output').textContent = data.gear;
            document.getElementById('fuel-output').textContent = data.fuel;
            $("#vehiclehud").css("display", "flex")
        }

        if (data.type == 'closeAll') {
            $("#vehiclehud").css("display", "none")
        }
    });
});
