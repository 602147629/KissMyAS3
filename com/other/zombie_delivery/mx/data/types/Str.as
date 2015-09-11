class mx.data.types.Str extends mx.data.binding.DataType
{
    var maxLength, validationError, minLength;
    function Str()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc2 = super.getTypedValue(requestedType);
        if (_loc2.value == null && requestedType == "String")
        {
            _loc2.value = "";
        } // end if
        return (_loc2);
    } // End of the function
    function gettableTypes()
    {
        return (["String"]);
    } // End of the function
    function settableTypes()
    {
        return (["String"]);
    } // End of the function
    function validate(value)
    {
        var _loc2 = String(value);
        if (maxLength != null && _loc2.length > maxLength)
        {
            this.validationError(tooLongError);
        } // end if
        if (minLength != null && _loc2.length < minLength)
        {
            this.validationError(tooShortError);
        } // end if
    } // End of the function
    var tooLongError = "This string is longer than the maximum allowed length.";
    var tooShortError = "This string is shorter than the minimum allowed length.";
} // End of Class
