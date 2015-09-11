class mx.data.types.DataProvider extends mx.data.binding.DataType
{
    var component, property, dataAccessor;
    function DataProvider()
    {
        super();
    } // End of the function
    function gettableTypes()
    {
        return (["DataProvider"]);
    } // End of the function
    function settableTypes()
    {
        return (["DataProvider", "Array", "String", "Object"]);
    } // End of the function
    function setTypedValue(newValue)
    {
        var _loc4 = null;
        var _loc3 = new mx.data.binding.TypedValue();
        _loc3.typeName = "DataProvider";
        if (newValue.typeName == "DataProvider")
        {
            _loc3.value = newValue.value;
            _loc3.type = newValue.type;
        }
        else if (newValue.typeName == "Array")
        {
            _loc3.value = mx.data.binding.FieldAccessor.wrapArray(newValue.value, newValue.type.elements[0].type, component.getBindingMetaData("acceptedTypes")[property]);
            _loc3.type = newValue.type;
        }
        else if (newValue.typeName == "String")
        {
            _loc3.value = newValue.value.split(",");
        }
        else if (newValue.typeName == "Object")
        {
            _loc3.value = newValue.value;
            _loc3.type = newValue.type;
        }
        else
        {
            _loc4 = [mx.data.binding.DataAccessor.conversionFailed(newValue, "DataProvider")];
        } // end else if
        if (typeof(_loc3.value.editField) != "function")
        {
            component.__setReadOnly(true);
        } // end if
        var _loc5 = dataAccessor.setTypedValue(_loc3);
        if (_loc4 != null)
        {
            return (_loc4);
        }
        else
        {
            return (_loc5);
        } // end else if
    } // End of the function
    function validate()
    {
    } // End of the function
} // End of Class
