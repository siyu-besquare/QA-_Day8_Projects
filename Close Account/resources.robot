*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email field}    //input[@type='email']
${account info button}    dt_core_account-info_acc-info
${loading interface}    //*[@aria-label="Loading interface..."]
${rise button}    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]
${empty text boxes}    //*[@class="dc-input__field dc-input__textarea dc-input__field--placeholder-visible"]
${textbox 1}    //*[@name="other_trading_platforms"]

*** Keywords ***
Login
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${rise button}    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    ${email field}    10
    Input Text    ${email field}    
    Input Text    //input[@type='password']    
    Click Element    //button[@type='submit']
    Wait Until Page Does Not Contain Element    ${loading interface}      30


Navigate to Close Account Page
    Click Element    //*[@class="account-settings-toggle"]
    Wait Until Page Contains Element    /account/closing-account    30
    Click Element    /account/closing-account
    Wait Until Page Contains Element    //*[@class="dc-text closing-account__title"]    30


Click Hyperlink
    Click Element    //*[@class="link" and contains(.,'Security and privacy policy')]
    Go To    https://deriv.com/tnc/security-and-privacy.pdf
    Wait Until Location Is    https://deriv.com/tnc/security-and-privacy.pdf


Click Cancel 
    Click Element    //*[@class="dc-btn dc-btn--secondary dc-btn__large closing-account__button--cancel"]
    Wait Until Page Contains Element    ${rise button}    30


Click "Close my account" Button
    Click Element    //*[@class="dc-btn dc-btn--primary dc-btn__large closing-account__button--close-account"]
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__title"]    30


Check Inactive Checkboxes
    Wait Until Page Does Not Contain Element    //*[@class="dc-icon dc-icon--active"]    30
    Wait Until Page Contains Element    //*[@disabled]    30

Check Empty Textboxes
    Wait Until Page Contains Element    ${empty text boxes}    30
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'110')]    30


Click Checkbox
    [Arguments]    ${reason}
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'${reason}')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'${reason}')]
    Wait Until Page Does Not Contain Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30

Activate "Continue" Button
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'I have other financial priorities.')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30
    Wait Until Page Does Not Contain Element    //*[@disabled]    30

Maximum Active Checkboxes
    Wait Until Page Does Not Contain Element    //*[@class="dc-checkbox__box dc-checkbox__box--disabled"]    30
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'I want to stop myself from trading.')]
    Click Element    //*[@class="dc-text dc-checkbox__label" and contains(.,'I’m no longer interested in trading.')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox__box dc-checkbox__box--disabled"]    30
    
    
Insert Into Textboxes
    Input Text    ${textbox 1}    test message test message test message test message test message 
    Input Text     //*[@name="do_to_improve"]   test message test message test message test me
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 0')]    30
    

Countdown Remaining Characters
    Press Keys    ${textbox 1}    CTRL+A    BACKSPACE
    Press Keys    //*[@name="do_to_improve"]    CTRL+A    BACKSPACE
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 110')]    30
    Input Text    ${textbox 1}    T
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 109')]    30
    Input Text    ${textbox 1}    E
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 108')]    30
    Input Text    ${textbox 1}    S
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 107')]    30
    Input Text    ${textbox 1}    T
    Wait Until Page Contains Element    //*[@class="dc-text closing-account-reasons__hint" and contains(.,'Remaining characters: 106')]    30


Click Back Button
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large"]
    Wait Until Page Contains Element    //*[@class="dc-text closing-account__title"]    30


Click X Button
    Click Element    //*[@class="dc-page-overlay__header-close"]
    Wait Until Page Contains Element    ${rise button}    30

Click "Continue" Button
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large"]
    Wait Until Page Contains Element    //*[@class="account-closure-warning-modal"]    30

Close Pop-up
    Wait Until Page Contains Element    //*[@class="dc-text dc-btn__text" and contains(.,'Go Back')]    30
    Click Element    //*[@class="dc-text dc-btn__text" and contains(.,'Go Back')]
    Wait Until Page Does Not Contain Element    //*[@class="account-closure-warning-modal"]    30

Click "Close Account" Button
    Click Element    //*[@class="dc-text dc-btn__text" and contains(.,'Close account')]
    Wait Until Page Contains Element    //*[@class="dc-text account-closed"]    30

Reactivate Account
    Wait Until Page Contains Element    dm-nav-login-button    30
    Click Element    dm-nav-login-button
    Input Text    ${email field}    si.yu@besquare.com.my
    Input Text    //input[@type='password']    DerivPassWord123
    Click Element    //button[@type='submit']
    Wait Until Page Contains Element    //*[@class="reactivate-title"]    30
    Click Element    btnGrant
    Wait Until Page Contains Element    ${rise button}    30