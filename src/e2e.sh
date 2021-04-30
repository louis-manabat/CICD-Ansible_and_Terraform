#!/usr/bin/env bash
npm install
npm start &
npx wait-on http://localhost:5000
npm run test-e2e
