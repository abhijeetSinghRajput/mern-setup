markdown
# 🚀 MERN Stack Project Setup Script

![MERN Stack](https://img.shields.io/badge/MERN-Full%20Stack-blue?logo=mongodb&logoColor=white)
![Vite](https://img.shields.io/badge/Vite-React%20Build-646CFF?logo=vite)
![ShadCN](https://img.shields.io/badge/ShadCN-UI%20Components-111827?logo=react)

This repository contains a script to automate the setup of a **MERN** (MongoDB, Express, React, Node.js) stack project with modern tooling.

## ✨ Features

### 🖥️ Frontend
- ⚡ [Vite](https://vitejs.dev/) - Blazing fast React development
- 🎨 [TailwindCSS](https://tailwindcss.com/) with PostCSS and autoprefixer
- 📁 Path aliases (`@/`) via `jsconfig.json`
- ✨ [ShadCN UI](https://ui.shadcn.com/) components with theme provider
- 🌓 Pre-configured `ModeToggle` for light/dark themes

### ⚙️ Backend
- 🚀 [Express](https://expressjs.com/) server with essential middleware
- 🍃 [Mongoose](https://mongoosejs.com/) for MongoDB connection
- 🔒 Environment variables via `.env`
- 🗂️ Organized structure:
backend/
├── models/
├── controllers/
├── routes/
└── services/


## 📋 Prerequisites

- [Node.js](https://nodejs.org/) (v18+) and npm
- [MongoDB](https://www.mongodb.com/) connection URI
- Terminal (Bash/Zsh for `.sh`, CMD for `.bat`)

## 🛠️ Usage

### 1. Clone and setup
```bash
git clone <repository-url>
cd <repository-folder>
chmod +x setup-mern.sh
./setup-mern.sh
2. Run Frontend
bash
cd frontend
npm install
npm run dev
3. Run Backend
bash
cd backend
npm install
npm run dev
4. Configure .env
Create backend/.env with:

env
DB_URI=your_mongodb_uri
PORT=5000
NODE_ENV=development
JWT_SECRET=your_jwt_secret
🎨 Customization Tips
Add more ShadCN components:
bash
npx shadcn add <component>
Recommended additions:
🧩 Zustand for state management

🔄 React Query for data fetching

📡 Socket.IO for real-time features

🤝 Contributing
We welcome contributions! Here's how:

bash
# 1. Fork the repository
# 2. Create your feature branch
git checkout -b feature/your-feature

# 3. Commit changes
git commit -m "feat: add your feature"

# 4. Push to branch
git push origin feature/your-feature

# 5. Open a Pull Request
📜 License
MIT © Abhijeet Singh

⭐ Star this repo if you found it useful!
🔗 Share with others to help the community grow.


Key improvements:
1. Added technology icons using shields.io badges
2. Improved section headers with emojis
3. Better code block formatting
4. More organized feature listings
5. Clearer contribution steps
6. Added recommended libraries section
7. Better visual hierarchy
8. Consistent command formatting
9. Added proper spacing between sections
10. More professional footer with call-to-action

The README now has better visual appeal while maintaining all technical information. The icons help quickly identify technologies at a glance.
