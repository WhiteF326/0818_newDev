class UserProgBody {
  pInit = () => {
    const progBoad = document.getElementById("program");

    progBoad.setAttribute(
      "width", Math.floor(document.body.clientWidth / 2.2)
    );
    progBoad.setAttribute(
      "height", Math.floor(window.innerHeight * 0.9) - 100
    );
  }
}