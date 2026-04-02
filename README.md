## 📝 Notes for the Reviewer

Hey! :) Thank you for taking the time to review this submission!

### AI Pair-Programming Transcript
In the spirit of transparency and modern development workflows, I have included the full transcript of my prompts and the AI's responses during the creation of this project.
- Full chat you can find here [`Full_AI_Transcript.md`](./Full_AI_Transcript.md) file.
- Prompts that were used during building application you can find here [`AI_Promts_That_Was_Used.md`](./AI_Promts_That_Was_Used.md)
- You can find my thoughts regarding the use of AI models during development here  [`Thoughts_On_Using_AI.md`](./Thoughts_On_Using_AI.md)

Thank you!:)




# Rock Paper Scissors

A lightweight Rock-Paper-Scissors game built with Ruby on Rails. Pick your throw, and the app fetches the server's move from an external API, determines the winner, and displays the result -- all in a clean, minimal UI powered by vanilla JavaScript.

---

## Tech Stack

| Layer         | Technology                        |
|---------------|-----------------------------------|
| Language      | Ruby 3.3.7                        |
| Framework     | Rails 7.2.2                       |
| Frontend      | Vanilla JavaScript, Slim templates|
| HTTP Client   | Net::HTTP (stdlib)                |
| Server        | Puma                              |
| Container     | Docker & Docker Compose           |
| Testing       | RSpec, WebMock                    |

---

## Setup Instructions (Docker)

This is the recommended way to run the application.

**Prerequisites:** Docker and Docker Compose installed.

1. Clone the repository:

   ```bash
   git clone <repo-url> && cd rock-paper-scissors-app
   ```

2. Create a `.env` file in the project root:

   ```bash
   RAILS_MASTER_KEY=<contents of config/master.key>
   ```

3. Build and start the services:

   ```bash
   docker compose up --build
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

To stop the services:

```bash
docker compose down
```

---

## Setup Instructions (Local Native)

**Prerequisites:** Ruby 3.3.7 and Bundler installed.

1. Clone the repository:

   ```bash
   git clone <repo-url> && cd rock-paper-scissors-app
   ```

2. Install dependencies:

   ```bash
   bundle install
   ```

3. Start the server:

   ```bash
   bin/rails server
   ```

4. Open [http://localhost:3000](http://localhost:3000) in your browser.

---

## Testing Suite

The project uses **RSpec** for unit, service, and request specs, and **WebMock** for stubbing external HTTP requests.

Run the full suite:

```bash
bundle exec rspec
```

Run with verbose output:

```bash
bundle exec rspec --format documentation
```

Run a specific spec file:

```bash
bundle exec rspec spec/models/game_spec.rb
```

### Test Coverage

| Spec File                                        | Scope                              |
|--------------------------------------------------|------------------------------------|
| `spec/models/game_spec.rb`                       | Game logic (win/lose/tie)          |
| `spec/services/rock_paper_scissors/client_spec.rb`  | API client (stubbed with WebMock)  |
| `spec/services/rock_paper_scissors/game_service_spec.rb` | Orchestration & fallback      |
| `spec/requests/games_spec.rb`                    | Controller request/response        |
| `spec/helpers/games_helper_spec.rb`              | View helper JSON output            |
