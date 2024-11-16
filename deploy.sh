#!/bin/bash

# Activate virtual environment
source venv/bin/activate

# Ensure dependencies are installed
pip install -r requirements.txt

# Run the application (adjust the command to match your app entry point)
python app.py