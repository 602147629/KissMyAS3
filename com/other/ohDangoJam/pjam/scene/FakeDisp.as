class pjam.scene.FakeDisp
{
    var root, scene;
    function FakeDisp(root)
    {
        this.root = root;
        scene = root.stageMC.fakeMC;
    } // End of the function
    function main()
    {
        var sc = this;
        scene.okBtn.onPress = function ()
        {
            sc.end();
        };
    } // End of the function
} // End of Class
