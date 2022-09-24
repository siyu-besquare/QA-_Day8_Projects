# Based on manual test cases written in testcases.txt file

*** Settings ***
Library    SeleniumLibrary
Resource    resources.robot

*** Test Cases ***
Login to Deriv
    Login


Navigate to Page
    Navigate to API Token Settings

Scrollable Middle Section
    Middle Section of Page is Scrollable

Settings Page Default States
    Checkboxes Default State
    Text Field Default State


Test Checkboxes
    Test Checkbox    Read
    Test Checkbox    Trade
    Test Checkbox    Payments
    Test Checkbox    Trading information
    Test Checkbox    Admin


"Create" Button Default State
    Verify Disabled "Create" Button

Test Invalid Token Names
    Minimum/Maximum/Invalid Characters Token Name    a
    Minimum/Maximum/Invalid Characters Token Name    123456789012345678901234567890123
    Minimum/Maximum/Invalid Characters Token Name    !@#


Create Token
    Create and Validate Valid Token    test    Read
    Copy Token Button Without Admin Access


Mask and Unmask Token
    Test Token Masking


Delete Token
    Token Deletion


Create Multiple Tokens
    Create and Validate Valid Token    test1    Admin
    Copy Token Button With Admin Access
    Create and Validate Valid Token    test2    Read


Exit Page
    Exit Settings Page