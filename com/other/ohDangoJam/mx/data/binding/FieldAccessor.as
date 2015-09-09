class mx.data.binding.FieldAccessor
{
    var component, property, parentObj, fieldName, m_location, type, index, xpath, data;
    function FieldAccessor(component, property, parentObj, fieldName, type, index, parentField)
    {
        this.component = component;
        this.property = property;
        this.parentObj = parentObj;
        this.fieldName = fieldName;
        if (component == parentObj)
        {
            m_location = undefined;
        }
        else if (parentField.m_location == undefined)
        {
            m_location = fieldName;
        }
        else
        {
            m_location = parentField.m_location + "." + fieldName;
        } // end else if
        this.type = type;
        this.index = index;
    } // End of the function
    function getValue()
    {
        var _loc2 = this.getFieldData();
        if (_loc2 == null && type.value != undefined)
        {
            var _loc3 = new mx.data.binding.TypedValue(type.value, "String");
            _loc3.getDefault = true;
            component.getField(fieldName).setAnyTypedValue(_loc3);
            _loc2 = _loc3.value;
        } // end if
        if (this.isXML(_loc2) && _loc2.childNodes.length == 1 && _loc2.firstChild.nodeType == 3)
        {
            return (_loc2.firstChild.nodeValue);
        }
        else
        {
            return (_loc2);
        } // end else if
    } // End of the function
    function setValue(newValue, newTypedValue)
    {
        if (newTypedValue.getDefault)
        {
            newTypedValue.value = newValue;
        }
        else
        {
            if (xpath != null)
            {
                var _loc4 = this.getFieldData();
                if (_loc4 != null)
                {
                    mx.data.binding.FieldAccessor.setXMLData(_loc4, newValue);
                }
                else
                {
                    _global.__dataLogger.logData(component, "Can\'t assign to \'<property>:<xpath>\' because there is no element at the given path", this);
                } // end else if
            }
            else if (this.isXML(parentObj))
            {
                if (type.category == "attribute")
                {
                    parentObj.attributes[fieldName] = newValue;
                }
                else if (type.category == "array")
                {
                }
                else
                {
                    _loc4 = this.getOrCreateFieldData();
                    mx.data.binding.FieldAccessor.setXMLData(_loc4, newValue);
                } // end else if
            }
            else
            {
                if (parentObj == null)
                {
                    _global.__dataLogger.logData(component, "Can\'t set field \'<property>/<location>\' because the field doesn\'t exist", this);
                } // end if
                parentObj[fieldName] = newValue;
            } // end else if
            component.propertyModified(property, xpath == null && parentObj == component, newTypedValue.type);
        } // end else if
    } // End of the function
    static function isActionScriptPath(str)
    {
        var _loc2 = str.toLowerCase();
        var _loc3 = "0123456789abcdefghijklmnopqrstuvwxyz_.";
        for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
        {
            if (_loc3.indexOf(_loc2.charAt(_loc1)) == -1)
            {
                return (false);
            } // end if
        } // end of for
        return (true);
    } // End of the function
    static function createFieldAccessor(component, property, location, type, mustExist)
    {
        if (mustExist && component[property] == null)
        {
            _global.__dataLogger.logData(component, "Warning: property \'<property>\' does not exist", {property: property});
            return (null);
        } // end if
        var _loc5 = new mx.data.binding.FieldAccessor(component, property, component, property, type, null, null);
        if (location == null)
        {
            return (_loc5);
        } // end if
        var _loc7 = null;
        if (location.indices != null)
        {
            _loc7 = location.indices;
            location = location.path;
        } // end if
        if (typeof(location) == "string")
        {
            if (_loc7 != null)
            {
                _global.__dataLogger.logData(component, "Warning: ignoring index values for property \'<property>\', path \'<location>\'", {property: property, location: location});
            } // end if
            if (mx.data.binding.FieldAccessor.isActionScriptPath(String(location)))
            {
                location = location.split(".");
            }
            else
            {
                _loc5.xpath = location;
                return (_loc5);
            } // end if
        } // end else if
        if (location instanceof Array)
        {
            var _loc3;
            var _loc10 = 0;
            for (var _loc3 = 0; _loc3 < location.length; ++_loc3)
            {
                var _loc2 = null;
                var _loc4 = location[_loc3];
                if (_loc4 == "[n]")
                {
                    if (_loc7 == null)
                    {
                        _global.__dataLogger.logData(component, "Error: indices for <property>:<location> are null, but [n] appears in the location.", {property: property, location: location});
                        return (null);
                    } // end if
                    _loc2 = _loc7[_loc10++];
                    if (_loc2 == null)
                    {
                        _global.__dataLogger.logData(component, "Error: not enough index values for <property>:<location>", {property: property, location: location});
                        return (null);
                    } // end if
                } // end if
                _loc5 = _loc5.getChild(_loc4, _loc2, mustExist);
            } // end of for
            if (mustExist && _loc5.getValue() == null)
            {
                _global.__dataLogger.logData(component, "Warning: field <property>:<m_location> does not exist, or is null", _loc5);
            } // end if
            return (_loc5);
        }
        else
        {
            trace ("unrecognized location: " + mx.data.binding.ObjectDumper.toString(location));
            return (null);
        } // end else if
    } // End of the function
    function getFieldAccessor()
    {
        return (this);
    } // End of the function
    function getChild(childName, index, mustExist)
    {
        if (childName == ".")
        {
            return (this);
        } // end if
        var _loc2 = this.getOrCreateFieldData(mustExist);
        if (_loc2 == null)
        {
            return (null);
        } // end if
        var _loc4 = mx.data.binding.FieldAccessor.findElementType(type, childName);
        return (new mx.data.binding.FieldAccessor(component, property, _loc2, childName, _loc4, index, this));
    } // End of the function
    function getOrCreateFieldData(mustExist)
    {
        var _loc3 = this.getFieldData();
        if (_loc3 == null)
        {
            if (mustExist)
            {
                _global.__dataLogger.logData(component, "Warning: field <property>:<m_location> does not exist", this);
            }
            else
            {
                this.setupComplexField();
                _loc3 = this.getFieldData();
            } // end if
        } // end else if
        return (_loc3);
    } // End of the function
    function evaluateSubPath(obj, type)
    {
        var path = type.path;
        if (mx.data.binding.FieldAccessor.isActionScriptPath(path))
        {
            var tokens = path.split(".");
            var i = 0;
            while (i < tokens.length)
            {
                var token = tokens[i];
                if (this.isXML(obj))
                {
                    for (obj = obj.firstChild; obj != null; obj = obj.nextSibling)
                    {
                        if (mx.data.binding.FieldAccessor.toLocalName(obj.nodeName) == token)
                        {
                            break;
                        } // end if
                    } // end of for
                }
                else
                {
                    obj = obj[token];
                } // end else if
                if (obj == null)
                {
                    _global.__dataLogger.logData(this.component, "Warning: path \'<path>\' evaluates to null, at \'<token>\' in <t.property>:<t.m_location>", {path: path, token: token, t: this});
                    break;
                } // end if
                ++i;
            } // end while
        }
        else if (this.isXML(obj))
        {
            if (path.charAt(0) != "/")
            {
                path = "/" + path;
            } // end if
            if (obj.nodeName == null)
            {
                obj = obj.firstChild;
            }
            else
            {
                path = mx.data.binding.FieldAccessor.toLocalName(obj.nodeName) + path;
            } // end else if
            var category = type.category != null ? (type.category) : (type.elements.length > 0 ? ("complex") : ("simple"));
            if (category == "simple" || category == "attribute")
            {
                obj = eval("obj" + mx.xpath.XPathAPI.getEvalString(obj, path));
            }
            else if (category == "complex")
            {
                obj = mx.xpath.XPathAPI.selectSingleNode(obj, path);
            }
            else if (category == "array")
            {
                obj = mx.xpath.XPathAPI.selectNodeList(obj, path);
                
            } // end else if
        }
        else
        {
            _global.__dataLogger.logData(this.component, "Error: path \'<path>\' is an XPath. It cannot be applied to non-XML data <t.property>:<t.m_location>", {path: path, t: this});
        } // end else if
        return (obj);
    } // End of the function
    function getFieldData()
    {
        if (xpath != null)
        {
            for (var _loc4 = parentObj[fieldName].firstChild; _loc4 != null && _loc4.nodeType != 1; _loc4 = _loc4.nextSibling)
            {
            } // end of for
            var _loc10 = mx.xpath.XPathAPI.selectSingleNode(_loc4, xpath);
            return (_loc10);
        }
        else if (this.isXML(parentObj))
        {
            if (type.path != null)
            {
                return (this.evaluateSubPath(parentObj, type));
            } // end if
            if (type.category == "attribute")
            {
                var _loc5 = parentObj.attributes;
                for (var _loc8 in _loc5)
                {
                    if (mx.data.binding.FieldAccessor.toLocalName(_loc8) == fieldName)
                    {
                        return (_loc5[_loc8]);
                    } // end if
                } // end of for...in
                return;
            }
            else
            {
                var _loc3 = parentObj.firstChild;
                if (type.category == "array")
                {
                    var _loc6 = new Array();
                    while (_loc3 != null)
                    {
                        if (mx.data.binding.FieldAccessor.toLocalName(_loc3.nodeName) == fieldName)
                        {
                            _loc6.push(_loc3);
                        } // end if
                        _loc3 = _loc3.nextSibling;
                    } // end while
                    return (_loc6);
                }
                else
                {
                    while (_loc3 != null)
                    {
                        if (mx.data.binding.FieldAccessor.toLocalName(_loc3.nodeName) == fieldName)
                        {
                            return (_loc3);
                        } // end if
                        _loc3 = _loc3.nextSibling;
                    } // end while
                } // end else if
                return (null);
            } // end else if
        }
        else if (fieldName == "[n]")
        {
            var _loc7;
            if (index.component != null)
            {
                var _loc9 = index.component.getField(index.property, index.location);
                _loc7 = _loc9.getAnyTypedValue(["Number"]);
                _loc7 = _loc7.value;
            }
            else
            {
                _loc7 = index.constant;
            } // end else if
            var index = Number(_loc7);
            if (typeof(_loc7) == "undefined")
            {
                _global.__dataLogger.logData(component, "Error: index specification \'<index>\' was not supplied, or incorrect, for <t.property>:<t.m_location>", {index: index, t: this});
                return (null);
            }
            else if (index.toString() == "NaN")
            {
                _global.__dataLogger.logData(component, "Error: index value \'<index>\' for <t.property>:<t.m_location> is not a number", {index: index, t: this});
                return (null);
            }
            else if (!(parentObj instanceof Array))
            {
                _global.__dataLogger.logData(component, "Error: indexed field <property>:<m_location> is not an array", this);
                return (null);
            }
            else if (index < 0 || index >= parentObj.length)
            {
                _global.__dataLogger.logData(component, "Error: index \'<index>\' for <t.property>:<t.m_location> is out of bounds", {index: index, t: this});
                return (null);
            }
            else
            {
                _global.__dataLogger.logData(component, "Accessing item [<index>] of <t.property>:<t.m_location>", {index: index, t: this});
                return (parentObj[index]);
            } // end else if
        }
        else
        {
            if (type.path != null)
            {
                return (this.evaluateSubPath(parentObj, type));
            } // end if
            return (parentObj[fieldName]);
        } // end else if
    } // End of the function
    static function setXMLData(obj, newValue)
    {
        while (obj.hasChildNodes())
        {
            obj.firstChild.removeNode();
        } // end while
        var _loc2 = mx.data.binding.FieldAccessor.xmlNodeFactory.createTextNode(newValue);
        obj.appendChild(_loc2);
    } // End of the function
    function setupComplexField()
    {
        var _loc2;
        if (this.isXML(parentObj))
        {
            _loc2 = mx.data.binding.FieldAccessor.xmlNodeFactory.createElement(fieldName);
            parentObj.appendChild(_loc2);
        }
        else if (this.dataIsXML())
        {
            parentObj[fieldName] = new XML();
        }
        else
        {
            parentObj[fieldName] = new Object();
        } // end else if
    } // End of the function
    static function findElementType(type, name)
    {
        for (var _loc1 = 0; _loc1 < type.elements.length; ++_loc1)
        {
            if (type.elements[_loc1].name == name)
            {
                return (type.elements[_loc1].type);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    function isXML(obj)
    {
        return (obj instanceof XMLNode);
    } // End of the function
    function dataIsXML()
    {
        return (type.name == "XML");
    } // End of the function
    static function accessField(component, fieldName, desiredTypes)
    {
        var _loc1;
        _loc1 = desiredTypes[fieldName];
        if (_loc1 == null)
        {
            _loc1 = desiredTypes.dflt;
        } // end if
        if (_loc1 == null)
        {
            _loc1 = desiredTypes;
        } // end if
        var _loc4 = component.createField("data", [fieldName]);
        var _loc2 = _loc4.getAnyTypedValue([_loc1]);
        return (_loc2.value);
    } // End of the function
    static function ExpandRecord(obj, objectType, desiredTypes)
    {
        var _loc4 = new Object();
        mx.data.binding.ComponentMixins.initComponent(_loc4);
        _loc4.data = obj;
        _loc4.__schema = {elements: [{name: "data", type: objectType}]};
        var _loc2 = new Object();
        if (objectType.elements.length > 0)
        {
            for (var _loc3 = 0; _loc3 < objectType.elements.length; ++_loc3)
            {
                var _loc10 = objectType.elements[_loc3].name;
                _loc2[_loc10] = mx.data.binding.FieldAccessor.accessField(_loc4, _loc10, desiredTypes);
            } // end of for
        }
        else if (obj instanceof XML || obj instanceof XMLNode)
        {
            if (obj.childNodes.length == 1 && obj.firstChild.nodeType == 3)
            {
                return (obj.firstChild.nodeValue);
            } // end if
            for (var _loc5 = obj.lastChild; _loc5 != null; _loc5 = _loc5.previousSibling)
            {
                _loc10 = mx.data.binding.FieldAccessor.toLocalName(_loc5.nodeName);
                if (_loc10 != null && _loc2[_loc10] == null)
                {
                    _loc2[_loc10] = mx.data.binding.FieldAccessor.accessField(_loc4, _loc10, desiredTypes);
                } // end if
            } // end of for
            for (var _loc10 in obj.attributes)
            {
                if (_loc2[_loc10] != null)
                {
                    _global.__dataLogger.logData(null, "Warning: attribute \'<name>\' has same name as an element, in XML object <obj>", {name: _loc10, obj: obj});
                } // end if
                _loc2[_loc10] = mx.data.binding.FieldAccessor.accessField(_loc4, _loc10, desiredTypes);
            } // end of for...in
        }
        else
        {
            if (typeof(obj) != "object")
            {
                return (obj);
            } // end if
            for (var _loc10 in obj)
            {
                _loc2[_loc10] = mx.data.binding.FieldAccessor.accessField(_loc4, _loc10, desiredTypes);
            } // end of for...in
        } // end else if
        return (_loc2);
    } // End of the function
    static function wrapArray(theArray, itemType, desiredTypes)
    {
        var _loc4 = {getItemAt: function (index)
        {
            if (index < 0 || index >= data.length)
            {
                return;
            } // end if
            var _loc2 = data[index];
            if (_loc2 == undefined)
            {
                return;
            } // end if
            var _loc3 = mx.data.binding.FieldAccessor.ExpandRecord(_loc2, type, desiredTypes);
            return (_loc3);
        }, getItemID: function (index)
        {
            return (index);
        }, data: theArray, type: itemType, length: theArray.length};
        return (_loc4);
    } // End of the function
    static function toLocalName(nodeName)
    {
        var _loc1 = nodeName.split(":");
        var _loc2 = _loc1[_loc1.length - 1];
        return (_loc2);
    } // End of the function
    static var xmlNodeFactory = new XML();
} // End of Class
