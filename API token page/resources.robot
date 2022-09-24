*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${email field}    //input[@type='email']
${account info button}    dt_core_account-info_acc-info
${loading interface}    //*[@aria-label="Loading interface..."]
${rise button}    //div[@class='btn-purchase__text_wrapper' and contains(.,'Rise')]
${token name}    //*[@class="dc-input__field"]
${error token name}    //*[@class="dc-input da-api-token__input dc-input__input-group dc-input--error dc-input--hint"]
${empty token name}    //*[@class="dc-input da-api-token__input dc-input__input-group dc-input--hint"]
${token mask container}    //*[@class="da-api-token__pass-dot-container"]
${delete button}    //*[@class="dc-icon dc-clipboard da-api-token__delete-icon"]
${pop-up for delete}    //*[@class="dc-modal__container dc-modal__container--small dc-modal__container--enter-done"]

*** Keywords ***
Login
    Open Browser    https://app.deriv.com/    chrome
    Maximize Browser Window
    Wait Until Page Contains Element    ${rise button}    30
    Click Element    dt_login_button
    Wait Until Page Contains Element    ${email field}    10
    Input Text    ${email field}    si.yu@besquare.com.my
    Input Text    //input[@type='password']    DerivPassWord123
    Click Element    //button[@type='submit']
    Wait Until Page Does Not Contain Element    ${loading interface}      30


Navigate to API Token Settings
    Click Element    //*[@class="account-settings-toggle"]
    Wait Until Page Contains Element    dc_api-token_link    30
    Click Element    dc_api-token_link
    Wait Until Page Contains Element    //*[@class="dc-text da-article__header" and contains(.,'API token')]    30

Middle Section of Page is Scrollable
    Wait Until Page Contains Element    //*[@class="dc-themed-scrollbars da-api-token__scrollbars dc-themed-scrollbars__autohide"]    30

Checkboxes Default State
    Wait Until Page Does Not Contain Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30


Text Field Default State
    Wait Until Page Contains Element    ${empty token name}    30

Test Checkbox
    [Arguments]    ${checkbox name}
    Click Element    //*[@class="dc-checkbox" and contains(.,'${checkbox name}')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30
    Click Element    //*[@class="dc-checkbox" and contains(.,'${checkbox name}')]
    Wait Until Page Contains Element    //*[@class="dc-checkbox" and contains(.,'${checkbox name}')]    30


Verify Disabled "Create" Button
    Wait Until Page Does Not Contain Element    //*[@class="dc-checkbox__box dc-checkbox__box--active"]    30
    Wait Until Page Contains Element    ${empty token name}    30
    Wait Until Page Contains Element    //*[@disabled]    30
    Click Element    //*[@class="dc-checkbox" and contains(.,'Read')]
    Input Text    ${token name}    test
    Wait Until Page Does Not Contain Element    //*[@disabled]    30
    Click Element    //*[@class="dc-checkbox" and contains(.,'Read')]

Minimum/Maximum/Invalid Characters Token Name
    [Arguments]    ${min/max/invalid chars}
    Press Keys    ${token name}    CTRL+A    BACKSPACE
    Input Text    ${token name}    ${min/max/invalid chars}
    Wait Until Page Contains Element    //*[@class="dc-field dc-field--error"]    30
    Wait Until Page Contains Element    //*[@disabled]    30


Create and Validate Valid Token
    [Arguments]    ${name}    ${scope}
    # Wait Until Page Does Not Contain Element    //*[@class="dc-text" and contains(.,'${name}')]    30
    Click Element    //*[@class="dc-checkbox" and contains(.,'${scope}')]
    Press Keys    ${token name}    CTRL+A    BACKSPACE
    Input Text    ${token name}    ${name}
    Wait Until Page Does Not Contain Element    //*[@disabled]    30
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-btn__button-group da-api-token__button"]
    Wait Until Page Contains Element    //*[@class="dc-text" and contains(.,'${name}')]    30
    Wait Until Page Does Not Contain Element    //*[@class="da-api-token__table-scope-cell" and contains(.,'Payments')]    30
    Wait Until Page Contains Element    //*[@class="da-api-token__table-scopes-cell-block" and contains(.,'${scope}')]    30
    Wait Until Page Contains Element    //*[@class="dc-text" and contains(.,'Never')]    30
    Wait Until Page Contains Element    ${token mask container}    30


Test Token Masking
    Wait Until Page Contains Element    ${token mask container}    30
    Click Element    //*[@class="dc-icon da-api-token__visibility-icon"]
    Wait Until Page Does Not Contain Element    ${token mask container}    30
    Click Element    //*[@class="dc-icon da-api-token__visibility-icon"]
    Wait Until Page Contains Element    ${token mask container}    30


Token Deletion
    Click Element    ${delete button}
    Wait Until Page Contains Element    ${pop-up for delete}    30
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--secondary dc-btn__large dc-dialog__button"]
    Wait Until Page Does Not Contain Element    ${pop-up for delete}    30
    Click Element    ${delete button}
    Wait Until Page Contains Element    ${pop-up for delete}    30
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Wait Until Page Does Not Contain Element    ${pop-up for delete}    30
    Wait Until Page Does Not Contain Element    //*[@class="dc-text" and contains(.,'test')]    30


Copy Token Button Without Admin Access
    Click Element    //*[@class="dc-icon dc-clipboard"]
    Wait Until Page Contains Element    //*[@class="dc-clipboard__popover dc-popover__bubble"]    30


Copy Token Button With Admin Access
    Click Element    //*[@class="dc-icon dc-clipboard"]
    Wait Until Page Contains Element    //*[@class="dc-modal-body"]    30
    Click Element    //*[@class="dc-btn dc-btn__effect dc-btn--primary dc-btn__large dc-dialog__button"]
    Wait Until Page Does Not Contain Element    //*[@class="dc-modal-body"]    30


Exit Settings Page
    Click Element    //*[@class="dc-page-overlay__header-close"]
    Wait Until Page Contains Element    ${rise button}    30