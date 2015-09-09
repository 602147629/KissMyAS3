class mx.data.encoders.Num extends mx.data.binding.DataAccessor
{
    var dataAccessor;
    function Num()
    {
        super();
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc4;
        if (requestedType == "Number" || requestedType == null)
        {
            var _loc2 = dataAccessor.getTypedValue("String");
            var _loc3 = null;
            if (_loc2.value != null && _loc2.value.length > 0)
            {
                _loc3 = Number(_loc2.value);
            } // end if
            _loc4 = new mx.data.binding.TypedValue(_loc3, "Number");
        } // end if
        return (_loc4);
    } // End of the function
    function getGettableTypes()
    {
        return (["Number", "Integer"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == "Number" || newValue.typeName == "Integer")
        {
            var _loc3;
            if (newValue.value != null)
            {
                _loc3 = newValue.value.toString();
            }
            else
            {
                _loc3 = "";
            } // end else if
            return (dataAccessor.setTypedValue(new mx.data.binding.TypedValue(_loc3, newValue.typeName)));
        }
        else
        {
            return ([mx.data.binding.DataAccessor.conversionFailed(newValue, newValue.typeName)]);
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        return (["Number", "Integer"]);
    } // End of the function
} // End of Class
