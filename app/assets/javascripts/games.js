document.addEventListener("DOMContentLoaded", () => {
  const gameData = document.getElementById("game-data");
  if (!gameData) return;

  const throwIcons = JSON.parse(gameData.dataset.throwIcons);
  const playUrl = gameData.dataset.playUrl;
  const i18n = JSON.parse(gameData.dataset.i18n);
  const csrfToken = document.querySelector('meta[name="csrf-token"]').content;


  const elements = {
    waitingModal: document.getElementById("waiting-modal"),
    waitingPlayerIcon: document.getElementById("waiting-player-icon"),
    resultModal: document.getElementById("result-modal"),
    resultTitle: document.getElementById("result-title"),
    resultDescription: document.getElementById("result-description"),
    resultIcon: document.getElementById("result-icon"),
    throwButtons: document.querySelectorAll(".throw-btn")
  };

  elements.throwButtons.forEach((btn) => {
    btn.addEventListener("click", () => handleThrow(btn.dataset.throw));
  });

  document.querySelectorAll("[data-action='close']").forEach((btn) => {
    btn.addEventListener("click", closeModals);
  });

  async function handleThrow(playerThrow) {
    showWaitingModal(playerThrow);
    setButtonsDisabled(true);

    try {
      const response = await fetch(playUrl, {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "X-CSRF-Token": csrfToken
        },
        body: JSON.stringify({ throw: playerThrow })
      });

      if (!response.ok) throw new Error(`Server error: ${response.status}`);

      const data = await response.json();
      showResultModal(data);
    } catch {
      closeModals();
      alert(i18n.errors.general);
    } finally {
      setButtonsDisabled(false);
    }
  }

  function showWaitingModal(playerThrow) {
    elements.waitingPlayerIcon.src = throwIcons[playerThrow];
    elements.waitingPlayerIcon.alt = playerThrow;
    elements.waitingModal.hidden = false;
  }

  function showResultModal(data) {
    elements.waitingModal.hidden = true;

    elements.resultTitle.textContent = i18n.results[data.result];
    elements.resultTitle.className = `modal-title result-${data.result}`;

    const verb = i18n.result_verbs[data.result];
    elements.resultDescription.textContent = `Curb with ${data.server_throw}${verb}`;

    elements.resultIcon.src = throwIcons[data.server_throw];
    elements.resultIcon.alt = data.server_throw;

    elements.resultModal.hidden = false;
  }

  function closeModals() {
    elements.waitingModal.hidden = true;
    elements.resultModal.hidden = true;
  }

  function setButtonsDisabled(disabled) {
    elements.throwButtons.forEach((btn) => { btn.disabled = disabled; });
  }
});
