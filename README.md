# MERN Stack Project Setup Script

This repository contains a script to automate the setup of a MERN (MongoDB, Express, React, Node.js) stack project. The script initializes both the frontend and backend environments with necessary configurations and dependencies.

## Features

- **Frontend**:
  - React app initialized with Vite.
  - TailwindCSS setup with PostCSS and autoprefixer.
  - Path aliases configured using `jsconfig.json` and `vite.config.js`.
  - Shadcn UI components and theme provider integration.
  - Pre-configured `ModeToggle` component for light/dark theme switching.

- **Backend**:
  - Express server with essential middleware.
  - MongoDB connection setup using Mongoose.
  - Environment variables managed via `.env`.
  - Pre-configured folder structure for models, controllers, routes, and services.

## Prerequisites

- Node.js and npm installed.
- MongoDB connection URI.
- Bash shell (for `.sh` script) or Windows Command Prompt (for `.bat` script).

## Usage

1. Clone this repository:
   ```bash
   git clone <repository-url>
   cd <repository-folder>