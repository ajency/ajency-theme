beforeEach ->
    window.$ = window.jQuery

    jasmine.addMatchers

        toBeTypeOf : ( expectedType ) ->
            actualType = @actual
            @message = ->
                "Expected '" + typeof actualType + "' to be type of '" + expectedType + "'"

            typeof actualType is expectedType

        toHaveOwnProperty : ( propertyName ) ->
            @actual.hasOwnProperty propertyName

        toContainHtml : ( html ) ->
            actualHtml = @actual.html()
            expectedHtml = jasmine.JQuery.browserTagCaseIndependentHtml( html )
            actualHtml.indexOf( expectedHtml ) >= 0

        toBeInstanceOf : ( object ) ->
            @actual instanceof object