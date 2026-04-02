# AI Prompts Used in This Project

A complete list of all prompts given to the AI assistant during the development of the Rock-Paper-Scissors application, organized by development phase.

---

## 1. Project Initialization

> Please initialize a new Rails application for a Rock-Paper-Scissors game. Use the Ruby and Rails versions that are already installed on my system. Since this is a lightweight application, please skip all unnecessary services to keep the footprint small (e.g., use the --minimal flag, or explicitly skip ActionMailer, ActionCable, ActiveStorage, ActionMailbox etc.)

---

## 2. Network Layer / API Client

> Implement the network layer. Inside app/services/rps/rps_api_client.rb, create a service class to fetch the server's throw from: https://5eddt4q9dk.execute-api.us-east-1.amazonaws.com/rps-stage/throw.
>
> Here is the expected JSON payload structure from the API we need to parse:
> - 200 OK Response: `{ "statusCode": 200, "body": "rock" }`
> - 500 Server Error Response: `{ "statusCode": 500, "body": "Something went wrong. Please try again later." }`
>
> I have strict networking and resilience requirements for this client:
> 1. HTTPS & Security: Ensure the connection explicitly enforces HTTPS (verify SSL/TLS).
> 2. Timeouts: We cannot let the app hang if the external API is slow. Explicitly configure an open_timeout of 2 seconds and a read_timeout of 5 seconds.
> 3. Error Handling & Parsing: On a successful request, parse the JSON and extract the throw from the "body" key.
> 4. Use the standard Net::HTTP library.

---

## 3. Internationalization (I18n)

> Let's add I18n. We don't need a heavy external gem since Rails has I18n built-in, but please add the rails-i18n gem to our Gemfile to get the default locale data.
>
> Here is my strategy for the translations:
> 1. YAML Structure: Do not just dump all translations into the root of en.yml. Organize the YAML keys cleanly using Rails conventions (e.g., nesting under views:, activerecord: models:, and a specific rps_game: namespace for our custom UI text)
> 2. Execution: Please scan the files in app/views. Extract all the hardcoded English strings from those views and replace them with translations.

---

## 4. Frontend JavaScript

> Let's implement the frontend JavaScript for the game interactions. We are keeping this lightweight, so I want to use pure Vanilla JavaScript -- no external frontend frameworks.
>
> 1. Rails Data Integration: We will pass dynamic data (like image paths and the POST endpoint URL) from the Rails view to JS using a hidden HTML element with data-* attributes (e.g., #game-data). Parse this data on DOMContentLoaded.
> 2. Fetch API & CSRF: Implement a play(playerThrow) function that makes an asynchronous POST fetch request. Crucially, you must extract the X-CSRF-Token from the document meta tag and include it in the headers, or Rails will block the request.
> 3. Promise Handling: Handle the response cleanly. If successful, hide the waiting modal, map the result ('win', 'lose', 'tie') to a friendly message, and display the result modal with the server's throw icon. If the server throws an error, catch it, close the modals, and trigger a native alert. Use a .finally() block to re-enable the buttons regardless of the outcome.

---

## 5. JavaScript I18n Refactor (Removing Hardcoded Strings)

> I have done some refactoring in app/assets/javascripts/games.js, now, lets get rid of hardcoded strings.
>
> Please execute this refactor:
> 1. YAML Updates: Extract the JS hardcoded messages into our en.yml files under a new rps_game.javascript namespace.
> 2. The Layout Bridge: In our application.html.erb layout, add a `<script>` tag before our main JS loads that assigns these translations to a global variable safely.
> 3. The JS Refactor: Update the static games.js file to reference these translated strings via the window.I18n object instead of the hardcoded English text.

---

## 6. XSS Security Fix

> This works, but there's an XSS risk -- if any translation value contains a `"` or `</script>`, it'll break or allow injection. Use `j` (escape for JS) or better yet, pass it as a JSON data attribute like you already do with throwIcons.

---

## 7. CSS Cleanup & Documentation

> Let's clean up our styles to ensure they are highly maintainable. Please review app/assets/stylesheets/games.css.
>
> I need you to execute the following:
> 1. Documentation: Add clear, descriptive comments above each CSS block explaining exactly which DOM elements or UI components these styles apply to.
> 2. Refactoring: Refactor the stylesheet to remove any duplicated rules. Optimize the selectors for better CSS performance (avoid overly nested or deeply chained selectors), and ensure the grouping is logical.

---

## 8. Test Planning

> Please generate a bulleted list of test cases for the following components:
> 1. Game model -- core business logic, highest priority
> 2. RockPaperScissors::ApiClient -- external API integration
> 3. RockPaperScissors::GameService -- orchestration
> 4. GamesController -- request/response
> 5. GamesHelper -- view helper

---

## 9. Test Implementation: Game Model

> Let's start with:
> spec/models/game_spec.rb: Keep this clean using descriptive context blocks for the different win/lose/tie scenarios.

---

## 10. Test Implementation: API Client

> Next tests should cover:
> spec/services/rock_paper_scissors/client_spec.rb: You must use the webmock gem here. Stub the HTTP requests to simulate the 200 success, 500 error, and Net::ReadTimeout scenarios. Ensure no real network requests are made.

---

## 11. Test Implementation: Game Service

> Next one is:
> spec/services/rock_paper_scissors/game_service_spec.rb: Do not use WebMock here. Instead, mock the RockPaperScissors::Client using RSpec's allow(...).to receive(:call) or test doubles. We want to verify the orchestration and fallback behavior in isolation without re-testing the network layer.

---

## 12. Test Implementation: Request Spec (Controller)

> spec/requests/games_spec.rb: please write a Request Spec
> 1. For GET /, assert a 200 OK status and that the correct template is rendered.
> 2. For POST /play, write one context for a valid throw (asserting the correct JSON structure with player_throw, server_throw, and result) and another context for invalid/missing throws (asserting a 422 Unprocessable Entity status and the correct error JSON).

---

## 13. Test Implementation: Helper Spec

> spec/helpers/games_helper_spec.rb: Keep it simple. Just verify that #game_throw_icons_json and #game_i18n_json return valid, parseable JSON strings with the expected keys.

---

## 14. Docker Containerization

> Final step, let's containerize it. Please generate a production-ready Dockerfile and a docker-compose.yml file.

---

## 15. Docker Build Fix

> I just tried to build the project, but I hit this error: An error occurred while installing psych (5.3.1), and Bundler cannot continue.

---

## 16. README Generation

> Please generate a beautifully formatted Markdown README with the following sections:
> 1. Project Overview: A brief, engaging description of this Rock-Paper-Scissors application.
> 2. Tech Stack: Explicitly list the exact versions we used: Ruby 3.2.7, Rails 7.2.2, PostgreSQL 16, Vanilla JavaScript, and Docker. Mention the testing tools.
> 3. Setup Instructions (Docker): The primary, recommended way to run the app.
> 4. Setup Instructions (Local Native): The fallback way to run the app without Docker.
> 5. Testing Suite: Instructions on how to run the RSpec test suite.
