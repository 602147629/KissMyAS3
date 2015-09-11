class mx.data.types.Xm extends mx.data.binding.DataType
{
    var ignoreWhite, dataAccessor;
    function Xm()
    {
        super();
    } // End of the function
    function gettableTypes()
    {
        return (["XML"]);
    } // End of the function
    function settableTypes()
    {
        return (["XML", "String"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        var _loc4 = null;
        var _loc2 = new mx.data.binding.TypedValue();
        _loc2.typeName = "XML";
        if (newValue.typeName == "XML")
        {
            _loc2.value = newValue.value;
            _loc2.type = newValue.type;
        }
        else if (newValue.typeName == "String")
        {
            var _loc5 = new XML();
            _loc5.ignoreWhite = ignoreWhite == "true";
            _loc5.parseXML(newValue.value);
            _loc2.value = _loc5;
        }
        else
        {
            _loc4 = [mx.data.binding.DataAccessor.conversionFailed(newValue, "XML")];
        } // end else if
        var _loc6 = dataAccessor.setTypedValue(_loc2);
        if (_loc4 != null)
        {
            return (_loc4);
        }
        else
        {
            return (_loc6);
        } // end else if
    } // End of the function
    function validate()
    {
    } // End of the function
} // End of Class
