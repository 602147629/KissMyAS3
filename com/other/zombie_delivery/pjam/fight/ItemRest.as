class pjam.fight.ItemRest
{
    var root, pdata, scene, num;
    function ItemRest(root, pdata)
    {
        this.root = root;
        this.pdata = pdata;
        scene = root.stageMC.itemRestMC;
    } // End of the function
    function start(item)
    {
        var sc = this;
        var _loc4 = false;
        var _loc3 = pdata.getItemList();
        for (var _loc2 = 0; _loc2 < 3; ++_loc2)
        {
            scene["itemTxt" + _loc2].text = pjam.Charactor.getItemName(root, _loc3[_loc2]);
            scene["btn" + _loc2].num = _loc2;
            scene["btn" + _loc2].onPress = function ()
            {
                sc.pdata.setItem(num, item);
                sc.end();
            };
            if (_loc3[_loc2] == pdata.getCharNum() && _loc4 == false)
            {
                _loc4 = true;
                delete scene["btn" + _loc2].onPress;
                scene["btn" + _loc2].enabled = false;
            } // end if
        } // end of for
        scene.getItemTxt.text = pjam.Charactor.getItemName(root, item);
        scene.getBtn.onPress = function ()
        {
            sc.scene.btn0.enabled = false;
            sc.scene.btn1.enabled = false;
            sc.scene.btn2.enabled = false;
            sc.scene.getBtn.enabled = false;
            sc.end();
        };
    } // End of the function
} // End of Class
