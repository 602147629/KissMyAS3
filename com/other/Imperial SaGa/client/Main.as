package 
{
    import flash.display.*;
    import flash.events.*;

    public class Main extends Sprite
    {
        private static var _enterFrame:ProcessMain;
        private static var _applicationData:ApplicationData;

        public function Main() : void
        {
            _applicationData = new ApplicationData(this);
            _applicationData.setLoadPath(loaderInfo.url);
            _applicationData.setStartUpParam(loaderInfo.parameters);
            if (stage)
            {
                this.init();
            }
            else
            {
                addEventListener(Event.ADDED_TO_STAGE, this.init);
            }
            return;
        }// end function

        private function init(event:Event = null) : void
        {
            removeEventListener(Event.ADDED_TO_STAGE, this.init);
            _applicationData.loadConfig(this.cbConfigLoaded);
            return;
        }// end function

        private function cbConfigLoaded() : void
        {
            this.startProcess();
            return;
        }// end function

        private function startProcess() : void
        {
            _enterFrame = new ProcessMain();
            _enterFrame.init(this);
            addChild(_enterFrame);
            stage.addEventListener(Event.ENTER_FRAME, _enterFrame.onEnterFrame);
            return;
        }// end function

        public static function GetProcess() : ProcessMain
        {
            return _enterFrame;
        }// end function

        public static function GetApplicationData() : ApplicationData
        {
            return _applicationData;
        }// end function

    }
}
