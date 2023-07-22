# How to setup Python ML Architecture CI/CD Pipeline

Virtual Env setup to Coding, Coding to code quality, code quality to test cases execution and code formatting, build to end to end deployment using CI/CD pipeline) - will share article soon on ML Designing Data Preparation and Processing System

### Author : Vikas Choudhary [Linked-In Profile](linkedin.com/in/vikas-choudhary-72866b49)

## Agenda

1. How to write test cases for your python app
2. How to setup lint for code quality check in python app
3. How to format all code in python app
4. How to externalise lib and install them in one go
5. How to check code coverage in python app
6. How to use GitHub code-spaces for Virtual Env
7. How to set CI/CD workflow for continuous delivery


## Setup Virtual Codespace
1. Login in Github Account
2. create your repo and click on Code button
3. select Codespace which will provide virtual VS code.

## Setup Terminal on Virtual VS Code
```bash
# Check virtual env
which virtualenv
#1
virtualenv ~/.venv
#2
source ~/.venv/bin/activate
#3, will return installed python
which python
```

## Setup Project with Base Configuration
1. create Makefile and define all commands there like install, test, lint, format, all etc. Copy paste below content in Makefile
```bash
#Create Makefile
touch Makefile
```
```python
#Copy below content
install:
	pip install --upgrade pip &&\
		pip install -r dependencies.txt

test:
	python -m pytest -v tests

format:
	black src/*.py

lint:
	pylint --disable=R,C src/HelloWorld.py

all: install lint test format
```
2. Create file for dependencies or lib, you can keep any name but same name need to be used in Makefile
```bash
#Create dependencies.txt file
dependencies.txt
```
```python
## Dependecies for this code , you can add as per your requirements
pytest==7.4.0
pytest-cov==4.1.0
pylint==2.17.4
black==23.7.0
ipython==8.14.0
```
3. Create SRC folder and test folder for to keep source code & test cases respectively
```bash
#Create src folder
mkdir src
#Create tests folder
mkdir tests
```
4. Create one source file HelloWorld.py and one test file test_HelloWorld.py
```bash
#Create First Source file i.e. HelloWorld.py
touch src/HelloWorld.py

#Create First Test file i.e. test_HelloTest.py
touch tests/test_HelloTest.py
```
5. To check/confirm installed lib version (if you didn't know what version you need to use, define lib name only in dependencies.txt and run below command to check what version installed for your libs. define same in dependencies.txt file
```bash
#Hit enter to continue 
pip freeze | less
```
## Finally Run Your Code
```bash
#if you only want to install libs
make install
#if you only want to check code quality
make lint
#if you only want to verify test and code coverage
make test
#if you only want to format all code files
make format
#if you want to do all above things in one go but in sequence
make all
```

```Python
#If everything looks good and your code compiled successfully 
#and passed all test cases. Output looks like below

Output:
        --------------------------------------------------------------------
        Your code has been rated at 10.00/10 (previous run: 10.00/10, +0.00)

        python -m pytest -v tests
        ================================================== test session starts ==================================================
        platform linux -- Python 3.10.8, pytest-7.4.0, pluggy-1.2.0 -- /home/codespace/.venv/bin/python
        cachedir: .pytest_cache
        rootdir: /workspaces/python-ML
        plugins: cov-4.1.0
        collected 1 item                                                                                                        

        tests/test_HelloWorld.py::test_hello_world PASSED                                                                 [100%]

        =================================================== 1 passed in 0.01s ===================================================
        black src/*.py
        All done! ✨ 🍰 ✨   
```

## Push Changes in Repo
```bash
#Check modified or added file status
git status
#To add all file in one go
git add *
#To Commit  
git commit -m "Python ML initial code for continues integration"
#To Push in Origin
git push 
```
## How to setup GitHub Actions for auto-build and deployment
1. Go to GitHub repo you want to setup
2. Click on Actions then you can select pre defined templates for your workflow or you can setup it manually.
3. To setup yourself, click on Setup workflow yourself
4. Copy paste below code in yaml file, or can add/modify commands as per your need. if you can use default file name as main or can change as per your need. In my case i changed it to deployment.yaml
```python
name: Test Python Auto Build
        on: [push]
        jobs:
        build:
            runs-on: ubuntu-latest
            strategy:
            matrix:
                python-version: [3.10.8]
            steps:
            - uses: actions/checkout@v2
            - name: Set up Python ${{ matrix.python-version }}
                uses: actions/setup-python@v2
                with:
                python-version: ${{ matrix.python-version }}
            - name: Install dependencies
                run: |
                make install
            - name: Lint with pylint
                run: |
                make lint
            - name: Test with pytest
                run: |
                make test
            - name: Format code with Python Black
                run: |
                make format
```
5. On every push in repo , it will installed all required lib, will run lint, then will run test cases and formatted the code and will deploy....
## Contributing

Pull requests are welcome. For major changes, please open an issue first
to discuss what you would like to change.

Please make sure to update tests as appropriate.

### Thank you
