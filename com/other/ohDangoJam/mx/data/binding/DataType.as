class mx.data.binding.DataType extends mx.data.binding.DataAccessor
{
    var errorArray, type, kind, dataAccessor, encoder, formatter, getAnyTypedValue, setAnyTypedValue, component, location, property;
    function DataType()
    {
        super();
        errorArray = null;
    } // End of the function
    function setupDataAccessor(component, property, location)
    {
        super.setupDataAccessor(component, property, location);
        type = component.findSchema(property, location);
        if (type.kind != undefined)
        {
            kind = mx.data.binding.Binding.getRuntimeObject(type.kind);
        }
        else
        {
            kind = new mx.data.kinds.Data();
        } // end else if
        kind.setupDataAccessor(component, property, location);
        dataAccessor = kind;
        if (type.encoder != undefined)
        {
            encoder = mx.data.binding.Binding.getRuntimeObject(type.encoder);
            encoder.setupDataAccessor(component, property, location);
            encoder.dataAccessor = dataAccessor;
            dataAccessor = encoder;
        } // end if
        if (type.formatter != undefined)
        {
            formatter = mx.data.binding.Binding.getRuntimeObject(type.formatter);
            formatter.setupDataAccessor(component, property, location);
            formatter.dataAccessor = dataAccessor;
        } // end if
    } // End of the function
    function getAsBoolean()
    {
        var _loc2 = this.getAnyTypedValue(["Boolean"]);
        return (_loc2.value);
    } // End of the function
    function getAsNumber()
    {
        var _loc2 = this.getAnyTypedValue(["Number"]);
        return (_loc2.value);
    } // End of the function
    function getAsString()
    {
        var _loc2 = this.getAnyTypedValue(["String"]);
        return (_loc2.value);
    } // End of the function
    function setAsBoolean(newValue)
    {
        this.setAnyTypedValue(new mx.data.binding.TypedValue(newValue, "Boolean"));
    } // End of the function
    function setAsNumber(newValue)
    {
        this.setAnyTypedValue(new mx.data.binding.TypedValue(newValue, "Number"));
    } // End of the function
    function setAsString(newValue)
    {
        this.setAnyTypedValue(new mx.data.binding.TypedValue(newValue, "String"));
    } // End of the function
    function validationError(errorMessage)
    {
        if (errorArray == null)
        {
            errorArray = new Array();
        } // end if
        errorArray.push(errorMessage);
    } // End of the function
    function validate(value)
    {
    } // End of the function
    function getTypedValue(requestedType)
    {
        var _loc2;
        if (requestedType == "String" && formatter != null)
        {
            _loc2 = formatter.getTypedValue(requestedType);
        }
        else
        {
            _loc2 = dataAccessor.getTypedValue(requestedType);
            if (_loc2.type == null)
            {
                _loc2.type = type;
            } // end if
            if (_loc2.typeName == null)
            {
                _loc2.typeName = type.name;
            } // end if
        } // end else if
        if (_loc2.typeName != requestedType && requestedType != null)
        {
            _loc2 = null;
        }
        else if (!requestedType && _loc2.typeName == "XML" && _loc2.type.name == "String")
        {
            _loc2 = null;
        } // end else if
        return (_loc2);
    } // End of the function
    function getGettableTypes()
    {
        var _loc2 = new Array();
        var _loc3 = this.gettableTypes();
        if (_loc3 != null)
        {
            _loc2 = _loc2.concat(_loc3);
        } // end if
        if (type.name != null)
        {
            _loc2 = _loc2.concat(type.name);
        } // end if
        if (formatter != null)
        {
            _loc2 = _loc2.concat(formatter.getGettableTypes());
        } // end if
        if (_loc2.length == 0)
        {
            return (null);
        }
        else
        {
            return (_loc2);
        } // end else if
    } // End of the function
    function setTypedValue(newValue)
    {
        if (newValue.typeName == "String" && formatter != null)
        {
            return (formatter.setTypedValue(newValue));
        }
        else
        {
            var _loc3 = dataAccessor.getSettableTypes();
            if (_loc3 == null || mx.data.binding.DataAccessor.findString(newValue.typeName, _loc3) != -1)
            {
                return (dataAccessor.setTypedValue(newValue));
            }
            else
            {
                return (["Can\'t set a value of type " + newValue.typeName]);
            } // end else if
        } // end else if
    } // End of the function
    function getSettableTypes()
    {
        var _loc2 = new Array();
        var _loc3 = this.settableTypes();
        if (_loc3 != null)
        {
            _loc2 = _loc2.concat(_loc3);
        } // end if
        if (type.name != null)
        {
            _loc2 = _loc2.concat(type.name);
        } // end if
        if (formatter != null)
        {
            _loc2 = _loc2.concat(formatter.getSettableTypes());
        } // end if
        if (_loc2.length == 0)
        {
            return (null);
        }
        else
        {
            return (_loc2);
        } // end else if
    } // End of the function
    function gettableTypes()
    {
        return (dataAccessor.getGettableTypes());
    } // End of the function
    function settableTypes()
    {
        return (dataAccessor.getSettableTypes());
    } // End of the function
    function validateAndNotify(returnData, noEvent, initialMessages)
    {
        var _loc4 = false;
        errorArray = null;
        for (var _loc6 in initialMessages)
        {
            this.validationError(initialMessages[_loc6]);
            _loc4 = true;
        } // end of for...in
        var _loc7 = this.getTypedValue();
        if (_loc7.value == null || _loc7.value == "")
        {
            if (type.required == false)
            {
                _global.__dataLogger.logData(component, "Validation of null value succeeded because field \'<property>/<m_location>\' is not required", this);
            }
            else
            {
                var _loc8 = location == null ? ("") : (":" + String(location));
                this.validationError("Required item \'" + property + _loc8 + "\' is missing");
                _loc4 = true;
            } // end else if
        }
        else
        {
            this.validate(_loc7.value);
            _loc4 = true;
        } // end else if
        if (_loc4 && noEvent != true)
        {
            var _loc5 = new Object();
            _loc5.type = errorArray == null ? ("valid") : ("invalid");
            _loc5.property = property;
            _loc5.location = location;
            _loc5.messages = errorArray;
            component.dispatchEvent(_loc5);
            returnData.event = _loc5;
        } // end if
        return (errorArray);
    } // End of the function
} // End of Class
