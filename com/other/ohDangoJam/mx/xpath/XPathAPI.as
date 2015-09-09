class mx.xpath.XPathAPI
{
    function XPathAPI()
    {
    } // End of the function
    static function getEvalString(node, path)
    {
        var _loc7 = "";
        var _loc4 = null;
        var _loc9 = mx.xpath.XPathAPI.getPathSet(path);
        var _loc3 = _loc9[0].nodeName;
        var _loc8;
        var _loc2 = node;
        var _loc5 = false;
        if (_loc3 != undefined && (_loc3 == "*" || node.nodeName == _loc3))
        {
            for (var _loc6 = 1; _loc6 < _loc9.length; ++_loc6)
            {
                _loc3 = _loc9[_loc6].nodeName;
                _loc8 = _loc3.indexOf("@");
                if (_loc8 >= 0)
                {
                    _loc3 = _loc3.substring(_loc8 + 1);
                    _loc5 = _loc2.attributes[_loc3] != undefined;
                    _loc7 = _loc7 + (".attributes." + _loc3);
                }
                else
                {
                    _loc5 = false;
                    for (var _loc1 = 0; _loc1 < _loc2.childNodes.length; ++_loc1)
                    {
                        _loc4 = _loc2.childNodes[_loc1];
                        if (_loc4.nodeName == _loc3)
                        {
                            _loc7 = _loc7 + (".childNodes." + _loc1);
                            _loc1 = _loc2.childNodes.length;
                            _loc2 = _loc4;
                            _loc5 = true;
                        } // end if
                    } // end of for
                } // end else if
                if (!_loc5)
                {
                    return ("");
                } // end if
            } // end of for
            if (!_loc5)
            {
                _loc7 = "";
            }
            else if (_loc8 == -1)
            {
                _loc7 = _loc7 + ".firstChild.nodeValue";
            } // end else if
        }
        else
        {
            _loc7 = "";
        } // end else if
        return (_loc7);
    } // End of the function
    static function selectNodeList(node, path)
    {
        var _loc2 = new Array(node);
        var _loc5 = mx.xpath.XPathAPI.getPathSet(path);
        var _loc4 = _loc5[0];
        var _loc6 = _loc4.__get__nodeName();
        var _loc1 = null;
        if (_loc6 != undefined && (_loc6 == "*" || node.nodeName == _loc6))
        {
            if (_loc4.__get__filter().length > 0)
            {
                _loc1 = new mx.xpath.FilterStack(_loc4.__get__filter());
                _loc2 = mx.xpath.XPathAPI.filterNodes(_loc2, _loc1);
            } // end if
            if (_loc2.length > 0)
            {
                for (var _loc3 = 1; _loc3 < _loc5.length; ++_loc3)
                {
                    _loc4 = _loc5[_loc3];
                    _loc2 = mx.xpath.XPathAPI.getAllChildNodesByName(_loc2, _loc4.__get__nodeName());
                    if (_loc4.__get__filter().length > 0)
                    {
                        _loc1 = new mx.xpath.FilterStack(_loc4.__get__filter());
                    }
                    else
                    {
                        _loc1 = null;
                    } // end else if
                    if (_loc1 != null && _loc1.__get__exprs().length > 0)
                    {
                        _loc2 = mx.xpath.XPathAPI.filterNodes(_loc2, _loc1);
                    } // end if
                } // end of for
            } // end if
        }
        else
        {
            _loc2 = new Array();
        } // end else if
        return (_loc2);
    } // End of the function
    static function selectSingleNode(node, path)
    {
        var _loc1 = mx.xpath.XPathAPI.selectNodeList(node, path);
        if (_loc1.length > 0)
        {
            return (_loc1[0]);
        }
        else
        {
            return (null);
        } // end else if
    } // End of the function
    static function setNodeValue(node, path, newValue)
    {
        var _loc1 = new Array(node);
        var _loc9 = mx.xpath.XPathAPI.getPathSet(path);
        var _loc7 = _loc9[_loc9.length - 1].nodeName;
        if (_loc7.charAt(0) == "@")
        {
            _loc7 = _loc7.substring(1, _loc7.length);
            _loc9.pop();
        }
        else
        {
            _loc7 = null;
        } // end else if
        var _loc5 = _loc9[0];
        var _loc11 = _loc5.__get__nodeName();
        var _loc3 = null;
        if (_loc11 != undefined && (_loc11 == "*" || node.nodeName == _loc11))
        {
            if (_loc5.__get__filter().length > 0)
            {
                _loc3 = new mx.xpath.FilterStack(_loc5.__get__filter());
                _loc1 = mx.xpath.XPathAPI.filterNodes(_loc1, _loc3);
            } // end if
            if (_loc1.length > 0)
            {
                for (var _loc2 = 1; _loc2 < _loc9.length; ++_loc2)
                {
                    _loc5 = _loc9[_loc2];
                    _loc1 = mx.xpath.XPathAPI.getAllChildNodesByName(_loc1, _loc5.__get__nodeName());
                    if (_loc5.__get__filter().length > 0)
                    {
                        _loc3 = new mx.xpath.FilterStack(_loc5.__get__filter());
                    }
                    else
                    {
                        _loc3 = null;
                    } // end else if
                    if (_loc3 != null && _loc3.__get__exprs().length > 0)
                    {
                        _loc1 = mx.xpath.XPathAPI.filterNodes(_loc1, _loc3);
                    } // end if
                } // end of for
            } // end if
        }
        else
        {
            _loc1 = new Array();
        } // end else if
        var _loc4 = null;
        var _loc6 = null;
        var _loc10 = new XML();
        for (var _loc2 = 0; _loc2 < _loc1.length; ++_loc2)
        {
            if (_loc7 != null)
            {
                _loc1[_loc2].attributes[_loc7] = newValue;
                continue;
            } // end if
            _loc4 = _loc1[_loc2];
            if (_loc4.firstChild == null || _loc4.firstChild.nodeType != 3)
            {
                _loc6 = _loc10.createTextNode(newValue);
                _loc4.appendChild(_loc6);
                continue;
            } // end if
            _loc6 = _loc4.firstChild;
            _loc6.nodeValue = newValue;
        } // end of for
        return (_loc1.length);
    } // End of the function
    static function copyStack(toStk, fromStk)
    {
        for (var _loc1 = 0; _loc1 < fromStk.length; ++_loc1)
        {
            toStk.splice(_loc1, 0, fromStk[_loc1]);
        } // end of for
    } // End of the function
    static function evalExpr(expr, node)
    {
        var _loc2 = true;
        if (expr.__get__attr())
        {
            _loc2 = expr.__get__value() != null ? (node.attributes[expr.__get__name()] == expr.__get__value()) : (node.attributes[expr.__get__name()] != null);
        }
        else
        {
            var _loc3 = mx.xpath.XPathAPI.getChildNodeByName(node, expr.__get__name());
            if (_loc3 != null)
            {
                _loc2 = expr.__get__value() != null ? (_loc3.firstChild.nodeValue == expr.__get__value()) : (true);
            }
            else
            {
                _loc2 = false;
            } // end else if
        } // end else if
        return (_loc2);
    } // End of the function
    static function filterNodes(nodeList, stack)
    {
        var _loc13 = new Array();
        var _loc2;
        var _loc3;
        var _loc9;
        var _loc6;
        var _loc10;
        var _loc1 = true;
        var _loc4;
        var _loc5;
        for (var _loc8 = 0; _loc8 < nodeList.length; ++_loc8)
        {
            _loc5 = true;
            _loc2 = new Array();
            _loc3 = new Array();
            mx.xpath.XPathAPI.copyStack(_loc2, stack.__get__exprs());
            mx.xpath.XPathAPI.copyStack(_loc3, stack.__get__ops());
            _loc4 = nodeList[_loc8];
            while (_loc2.length > 0 && _loc5)
            {
                if (typeof(_loc2[_loc2.length - 1]) == "object")
                {
                    _loc9 = (mx.xpath.FilterExpr)(_loc2.pop());
                    _loc1 = mx.xpath.XPathAPI.evalExpr(_loc9, _loc4);
                }
                else
                {
                    _loc10 = Boolean(_loc2.pop());
                    _loc1 = _loc10;
                } // end else if
                if (_loc3.length > 0)
                {
                    var _loc7 = _loc2.pop();
                    _loc6 = _loc7;
                    switch (_loc3[_loc3.length - 1])
                    {
                        case "and":
                        {
                            _loc1 = _loc1 && mx.xpath.XPathAPI.evalExpr(_loc6, _loc4);
                            _loc5 = _loc1;
                            break;
                        } 
                        case "or":
                        {
                            _loc1 = _loc1 || mx.xpath.XPathAPI.evalExpr(_loc6, _loc4);
                            _loc5 = !_loc1;
                            break;
                        } 
                    } // End of switch
                    _loc3.pop();
                    _loc2.push(_loc1);
                } // end if
            } // end while
            if (_loc1)
            {
                _loc13.push(_loc4);
            } // end if
        } // end of for
        return (_loc13);
    } // End of the function
    static function getAllChildNodesByName(nodeList, name)
    {
        var _loc5 = new Array();
        var _loc2;
        for (var _loc3 = 0; _loc3 < nodeList.length; ++_loc3)
        {
            _loc2 = nodeList[_loc3].childNodes;
            if (_loc2 != null)
            {
                for (var _loc1 = 0; _loc1 < _loc2.length; ++_loc1)
                {
                    if (name == "*" || _loc2[_loc1].nodeName == name)
                    {
                        _loc5.push(_loc2[_loc1]);
                    } // end if
                } // end of for
            } // end if
        } // end of for
        return (_loc5);
    } // End of the function
    static function getChildNodeByName(node, nodeName)
    {
        var _loc2;
        var _loc3 = node.childNodes;
        for (var _loc1 = 0; _loc1 < _loc3.length; ++_loc1)
        {
            _loc2 = _loc3[_loc1];
            if (_loc2.nodeName == nodeName)
            {
                return (_loc2);
            } // end if
        } // end of for
        return (null);
    } // End of the function
    static function getKeyValues(node, keySpec)
    {
        var _loc5 = "";
        var _loc3 = new mx.utils.StringTokenParser(keySpec);
        var _loc2 = _loc3.nextToken();
        var _loc1;
        var _loc6;
        while (_loc2 != mx.utils.StringTokenParser.tkEOF)
        {
            _loc1 = _loc3.token;
            _loc5 = _loc5 + (" " + _loc1);
            if (_loc2 == mx.utils.StringTokenParser.tkSymbol)
            {
                if (_loc1 == "@")
                {
                    _loc2 = _loc3.nextToken();
                    _loc1 = _loc3.token;
                    if (_loc2 == mx.utils.StringTokenParser.tkSymbol)
                    {
                        _loc5 = _loc5 + (_loc1 + "=\'" + node.attributes[_loc1] + "\'");
                    } // end if
                }
                else if (_loc1 == "/")
                {
                    _loc2 = _loc3.nextToken();
                    if (_loc2 == mx.utils.StringTokenParser.tkSymbol)
                    {
                        _loc1 = _loc3.token;
                        node = mx.xpath.XPathAPI.getChildNodeByName(node, _loc1);
                        if (node != null)
                        {
                            _loc5 = _loc5 + _loc1;
                        } // end if
                    } // end if
                }
                else if (_loc1 != "and" && _loc1 != "or" && _loc1 != "[" && _loc1 != "]")
                {
                    _loc6 = mx.xpath.XPathAPI.getChildNodeByName(node, _loc1);
                    if (_loc6 != null)
                    {
                        _loc5 = _loc5 + ("=\'" + _loc6.firstChild.nodeValue + "\'");
                    } // end if
                } // end else if
            } // end else if
            if (node == null)
            {
                trace ("Invalid keySpec specified. \'" + keySpec + "\' Error.");
                return ("ERR");
            } // end if
            _loc2 = _loc3.nextToken();
        } // end while
        return (_loc5.slice(1));
    } // End of the function
    static function getPath(node, keySpecs)
    {
        var _loc2 = "";
        var _loc5 = keySpecs[node.nodeName];
        if (_loc5 == undefined)
        {
            var _loc8 = "";
            var _loc10;
            for (var _loc10 in node.attributes)
            {
                _loc8 = _loc8 + ("@" + _loc10 + "=\'" + node.attributes[_loc10] + "\' and ");
            } // end of for...in
            var _loc7 = "";
            var _loc1;
            var _loc6;
            for (var _loc4 = 0; _loc4 < node.childNodes.length; ++_loc4)
            {
                _loc1 = node.childNodes[_loc4];
                _loc6 = _loc1.firstChild.nodeValue;
                if (_loc6 != undefined)
                {
                    _loc7 = _loc7 + (_loc1.nodeName + "=\'" + _loc6 + "\' and ");
                } // end if
            } // end of for
            if (_loc8.length > 0)
            {
                if (_loc7.length > 0)
                {
                    _loc2 = "/" + node.nodeName + "[" + _loc8 + _loc7.substring(0, _loc7.length - 4) + "]";
                }
                else
                {
                    _loc2 = "/" + node.nodeName + "[" + _loc8.substring(0, _loc8.length - 4) + "]";
                } // end else if
            }
            else
            {
                _loc2 = "/" + node.nodeName + "[" + _loc7.substring(0, _loc7.length - 4) + "]";
            } // end else if
        }
        else
        {
            _loc2 = _loc2 + ("/" + node.nodeName + mx.xpath.XPathAPI.getKeyValues(node, _loc5));
        } // end else if
        for (var _loc1 = node.parentNode; _loc1.parentNode != null; _loc1 = _loc1.parentNode)
        {
            _loc5 = keySpecs[_loc1.nodeName];
            if (_loc5 != undefined)
            {
                _loc2 = "/" + _loc1.nodeName + mx.xpath.XPathAPI.getKeyValues(_loc1, _loc5) + _loc2;
                continue;
            } // end if
            _loc2 = "/" + _loc1.nodeName + _loc2;
        } // end of for
        return (_loc2);
    } // End of the function
    static function getPathSet(path)
    {
        var _loc6 = new Array();
        var _loc4;
        var _loc1;
        var _loc2;
        var _loc5;
        while (path.length > 0)
        {
            _loc4 = path.lastIndexOf("/");
            _loc1 = path.substring(_loc4 + 1);
            _loc2 = _loc1.indexOf("[", 0);
            _loc5 = _loc2 >= 0 ? (_loc1.substring(_loc2 + 1, _loc1.length - 1)) : ("");
            _loc1 = _loc2 >= 0 ? (_loc1.substring(0, _loc2)) : (_loc1);
            _loc6.splice(0, 0, new mx.xpath.NodePathInfo(_loc1, _loc5));
            path = path.substring(0, _loc4);
        } // end while
        return (_loc6);
    } // End of the function
} // End of Class
