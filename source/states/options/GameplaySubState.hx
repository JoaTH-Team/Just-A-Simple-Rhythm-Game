package states.options;

class GameplaySubState extends OptionsSubState
{
    public function new() {
        super();

        addTick("Uncapped FPS", SaveManager.save.data.uncappedFPS);
    }
}