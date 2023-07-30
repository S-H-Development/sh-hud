window.addEventListener('message', (event) => {
    const data = event.data;

    if (data.type == 'mainhud') {
        document.getElementById('id-output').textContent = data.id;
        document.getElementById('compass-output').textContent = data.direction;
        $("#mainhud").css("opacity", 1.0)
        $("#vehiclehud").css("opacity", 0.0)
    }

    if (data.type == 'vehiclehud') {
        document.getElementById('veh-id-output').textContent = data.id;
        document.getElementById('plate-output').textContent = data.plate;
        document.getElementById('speed-output').textContent = data.speed;
        document.getElementById('gear-output').textContent = data.gear;
        document.getElementById('fuel-output').textContent = data.fuel;
        document.getElementById('veh-compass-output').textContent = data.direction;
        $("#mainhud").css("opacity", 0.0)
        $("#vehiclehud").css("opacity", 1.0)
    }
});
