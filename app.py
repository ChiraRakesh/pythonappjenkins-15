from flask import Flask
 
app = Flask(__name__)
 
@app.route('/')
def home():
    return "Hello from python Flask App! This is a Rakesh Chira` python Flask ."
 
if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
