# //*[@class="dc-text account-closed"]

*** Settings ***
Library    SeleniumLibrary
Resource    resources.robot

*** Test Cases ***
Login to Deriv
    Login

Navigate to Page
    Navigate to Close Account Page

Test Buttons on Page 1
    Click Cancel
    Navigate to Close Account Page
    Click Hyperlink
    Go To    https://app.deriv.com/account/closing-account
    Click "Close my account" Button

Check Default State of Page 2
    Check Inactive Checkboxes
    Check Empty Textboxes


Test Checkboxes
    Click Checkbox    I have other financial priorities.
    Click Checkbox    I want to stop myself from trading.
    Click Checkbox    I’m no longer interested in trading.
    Click Checkbox    I prefer another trading website.
    Click Checkbox    The platforms aren’t user-friendly.
    Click Checkbox    Making deposits and withdrawals is difficult.
    Click Checkbox    The platforms lack key features or functionality.
    Click Checkbox    Customer service was unsatisfactory.
    Click Checkbox    I’m closing my account for other reasons.
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__error"]    30

Test Active "Continue" Button
    Activate "Continue" Button

Test Maximum Active Checkboxes
    Maximum Active Checkboxes

Test Maximum Characters for Textboxes
    Insert Into Textboxes

Test Remaining Characters Countdown
    Countdown Remaining Characters


Test Back Button
    Click Back Button

Test X Button
    Click X Button


Test "Continue" Button and Pop-up
    Navigate to Close Account Page
    Click "Close my account" Button
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'I have other financial priorities.')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30
    Click "Continue" Button
    Close Pop-up

Close Account
    Click "Close Account" Button

Test Account Reactivation
    Reactivate Account