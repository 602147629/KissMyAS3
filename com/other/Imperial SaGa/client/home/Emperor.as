package home
{
    import flash.display.*;
    import layer.*;
    import message.*;
    import player.*;
    import resource.*;
    import utility.*;

    public class Emperor extends Object
    {
        private var _isoMain:InStayOut;
        private var _emperorPng:Bitmap;
        private var _layer:LayerHome;
        private var _baseMc:MovieClip;

        public function Emperor(param1:LayerHome, param2:MovieClip, param3:int)
        {
            this._baseMc = param2;
            this._layer = param1;
            this._isoMain = new InStayOut(this._baseMc);
            var _loc_4:* = PlayerManager.getInstance().getPlayerInformation(param3);
            if (PlayerManager.getInstance().getPlayerInformation(param3) == null)
            {
                Assert.print("設定されていない皇帝が指定されています。");
            }
            TextControl.setText(this._baseMc.emperorNameMc.textMc.textDt, _loc_4.name);
            var _loc_5:* = PlayerManager.getInstance().getPlayerInformation(param3);
            this._emperorPng = ResourceManager.getInstance().createBitmap(ResourcePath.PLAYER_BUSTUP_PATH + _loc_5.bustUpFileName);
            if (this._emperorPng)
            {
                this._baseMc.charaNull.charaNull.addChild(this._emperorPng);
                this._emperorPng.smoothing = true;
                this._emperorPng.x = this._emperorPng.x - this._emperorPng.width / 2;
                this._emperorPng.y = this._emperorPng.y - this._emperorPng.height;
                if (_loc_5.id == PlayerId.ID_Jean_CL02_SR)
                {
                    this._emperorPng.y = this._emperorPng.y + 150;
                }
            }
            this._layer.getLayer(LayerHome.MAIN).addChild(this._baseMc);
            return;
        }// end function

        public function release() : void
        {
            if (this._isoMain)
            {
                this._isoMain.release();
            }
            this._isoMain = null;
            if (this._emperorPng)
            {
                if (this._emperorPng.parent)
                {
                    this._emperorPng.parent.removeChild(this._emperorPng);
                }
            }
            this._emperorPng = null;
            if (this._baseMc != null && this._baseMc.parent != null)
            {
                this._baseMc.parent.removeChild(this._baseMc);
            }
            this._baseMc = null;
            return;
        }// end function

        public function control() : void
        {
            return;
        }// end function

        public function get bOpend() : Boolean
        {
            return this._isoMain.bOpened;
        }// end function

        public function get bClosed() : Boolean
        {
            return this._isoMain.bClosed;
        }// end function

        public function get bAnime() : Boolean
        {
            return this._isoMain.bAnimetion;
        }// end function

        public function open() : void
        {
            if (this._isoMain.bClosed)
            {
                this._isoMain.setIn();
            }
            return;
        }// end function

        public function close() : void
        {
            if (this._isoMain.bOpened)
            {
                this._isoMain.setOut();
            }
            return;
        }// end function

    }
}
