#!/bin/bash

# Prompt for project name
read -p "Enter project name: " project_name

# Create project directory
mkdir "$project_name"
cd "$project_name" || exit

# Initialize Node.js project in root
npm init -y

# Create .gitignore
cat <<EOL > .gitignore
node_modules
dist
.env
EOL

# ------------------- FRONTEND SETUP ------------------- #

# Create frontend directory
mkdir frontend
cd frontend || exit

# Initialize Vite React project
npm create vite@latest . -- --template react

# Install dependencies
npm install
npm install -D tailwindcss@3 postcss autoprefixer
npx tailwindcss init -p
npm install axios react-router-dom zustand lucide-react

# Replace Tailwind config with CommonJS format
cat <<EOL > tailwind.config.js
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,jsx}"
  ],
  theme: {
    extend: {},
  },
  plugins: [],
}
EOL

# Ensure src directory exists and safely update index.css
mkdir -p src
rm -f src/index.css
cat <<EOL > src/index.css
@tailwind base;
@tailwind components;
@tailwind utilities;
EOL

# Create jsconfig.json for path aliases
cat <<EOL > jsconfig.json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./src/*"]
    }
  }
}
EOL

# Update vite.config.js for alias support
cat <<EOL > vite.config.js
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import path from 'path'

export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      "@": path.resolve(__dirname, "./src"),
    },
  },
})
EOL

# ------------------- SHADCN + THEME PROVIDER SETUP ------------------- #

# Initialize Shadcn UI
npx shadcn@latest init -y
npx shadcn@latest add button

# Create Mode toggler
mkdir -p src/components
cat <<EOL > src/components/mode-toggle.jsx
import { Moon, Sun } from "lucide-react";
import { Button } from "./ui/button";
import { useTheme } from "./theme-provider";

export function ModeToggle() {
  const { setTheme, theme } = useTheme();
  const toggleMode = () => {
    setTheme(theme === "light" ? "dark" : "light");
  }
  return (
    <Button
      variant="ghost"
      className="size-8"
      onClick={toggleMode}
    >
      <Sun className="h-[1.2rem] w-[1.2rem] rotate-0 scale-100 transition-all dark:-rotate-90 dark:scale-0" />
      <Moon className="absolute h-[1.2rem] w-[1.2rem] rotate-90 scale-0 transition-all dark:rotate-0 dark:scale-100" />
      <span className="sr-only">Toggle theme</span>
    </Button>
  );
}
EOL

cat <<EOL > src/components/theme-provider.jsx
import { createContext, useContext, useEffect, useState } from "react";

const ThemeProviderContext = createContext({
  theme: "system",
  setTheme: () => null,
});

export function ThemeProvider({ children, defaultTheme = "system", storageKey = "vite-ui-theme", ...props }) {
  const [theme, setTheme] = useState(() => localStorage.getItem(storageKey) || defaultTheme);

  useEffect(() => {
    const root = window.document.documentElement;
    root.classList.remove("light", "dark");

    if (theme === "system") {
      const systemTheme = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
      root.classList.add(systemTheme);
      return;
    }

    root.classList.add(theme);
  }, [theme]);

  const value = {
    theme,
    setTheme: (theme) => {
      localStorage.setItem(storageKey, theme);
      setTheme(theme);
    },
  };

  return (
    <ThemeProviderContext.Provider {...props} value={value}>
      {children}
    </ThemeProviderContext.Provider>
  );
}

export const useTheme = () => {
  const context = useContext(ThemeProviderContext);
  if (!context) throw new Error("useTheme must be used within a ThemeProvider");
  return context;
};
EOL

# Clean and replace App.jsx
rm -f src/App.css
cat > src/App.jsx <<EOF
import React from "react";
import { Button } from "./components/ui/button";
import { ThemeProvider } from "@/components/theme-provider";
import { ModeToggle } from "./components/mode-toggle";

const App = () => {
  return (
    <ThemeProvider defaultTheme="dark" storageKey="vite-ui-theme">
      <div className="p-4">
        <ModeToggle/>
        <Button>hello</Button>
      </div>
    </ThemeProvider>
  );
};

export default App;
EOF


# ------------------- BACKEND SETUP ------------------- #
cd ..
mkdir backend
cd backend || exit

# Initialize Node.js backend
npm init -y

# Install backend dependencies
npm install express mongoose dotenv cors cookie-parser bcryptjs jsonwebtoken ora
npm install -D nodemon

# Set type: module and dev script
npm pkg set type=module
npm pkg set scripts.dev="nodemon index.js"

# Create folders
mkdir models controllers routes services

# Create .env
cat <<EOL > .env
DB_URI=your_mongodb_uri
PORT=5000
NODE_ENV=development
JWT_SECRET=your_jwt_secret
EOL

# Create db.js
cat <<EOL > db.js
import mongoose from 'mongoose';
import ora from 'ora';

const connectDB = async () => {
  const spinner = ora('Connecting to MongoDB...').start();
  try {
    await mongoose.connect(process.env.DB_URI, {
      useNewUrlParser: true,
      useUnifiedTopology: true,
    });
    spinner.succeed('MongoDB connected');
  } catch (error) {
    spinner.fail('MongoDB connection failed');
    console.error(error);
    process.exit(1);
  }
};

export default connectDB;
EOL

# Create index.js with DB connection in listen callback
cat <<EOL > index.js
import express from 'express';
import dotenv from 'dotenv';
import cors from 'cors';
import connectDB from './db.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.status(200).json({ message: "Hello from server" });
});

app.listen(PORT, () => {
  console.log(\`Server is running on port \${PORT}\`);
  // connectDB();
});
EOL

echo "✅ Project '$project_name' setup completed!"
convert this to .bat file from .sh