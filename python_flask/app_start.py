from config import *
import subprocess
import sys

@app.route('/api/devDeploy', methods=['POST'])
def autoPull():
    subprocess.Popen(
        ["git", "pull"])
    os.execl(sys.executable, sys.executable, *sys.argv)


if __name__=='__main__':
    
    app.run('0.0.0.0')

