package haxegame.game.human
{
    import com.dango_itimi.as3_and_createjs.*;
    import com.dango_itimi.as3_and_createjs.display.*;
    import com.dango_itimi.as3_and_createjs.utils.*;
    import flash.*;
    import flash.display.*;
    import haxegame.game.character.*;

    public class GoalHuman extends GoalCharacter
    {

        public function GoalHuman(param1:IDisplayObjectContainer = undefined, param2:MovieClip = undefined) : void
        {
            if (Boot.skip_constructor)
            {
                return;
            }
            super(param1, param2);
            return;
        }// end function

        override public function createView() : void
        {
            neutralView = CommonClassSet.createMovieClipUtil(new NeutralView());
            missView = CommonClassSet.createMovieClipUtil(new MissView());
            successView = CommonClassSet.createMovieClipUtil(new SuccessView());
            gameOutView = CommonClassSet.createMovieClipUtil(new GameOutView());
            return;
        }// end function

    }
}
