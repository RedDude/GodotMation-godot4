# GodotMation
An implementation of machinations framework in Godot 4 

**WORK IN PROGRESS**

ABOUT:

GodotMation plugin, is an implementation of Machination framework by Joris Dormans in Godot Engine.

The original Machination is hosted at Joris Dormans site : http://www.jorisdormans.nl/machinations/ 
A new site of a newly developed Machination framework, can be found at : https://www.machinations.io/

You can read also about Machinations in Gamasutra : https://www.gamasutra.com/view/feature/176033/the_designers_notebook_.php
In the book "Game Mechanics: Advanced Game Design" by Ernest Adams and Joris Dormans
And in Joris Dormans' Dissertation "Engineering Emergence: Applied Theory for Game Design" at : https://www.illc.uva.nl/Research/Publications/Dissertations/DS-2012-12.text.pdf

Machinations are used mostly to examine or balance game mechanics, but GodotMation is trying to bring the diagram (framework) as a tool (plug in) for creating the actual mechanics.
Micro Machinations : https://github.com/vrozen/MM-Lib is another lib that it takes this root by creating a DSL (Domain Specific Language).

GodotMation is implemented in Godot Engine and does not share or "borrow" any source code from Machinations or Micro-Machinations nor does not use Micro Machinations, it is a complete new implementation.

Some futures were omitted in GodotMation :
1. Color Coding does not exist. Color may be used, but it is just to aid the organization-presentation of the diagram.
2. Trader does not exist, cause trader needs Color Coding.
3. Artificial Player was never implemented.
4. Register was never implemented (but we can always discuss this...)
5. Text Label is not implemented yet. (It will raise an error if you load an xml with this)
6. Group is not implemented yet. (It will raise an error if you load an xml with this)
7. Chart is not implemented yet. (It will raise an error if you load an xml with this)
8. Time mode is only at synchronous. You can trick it to trigger a node more than once.
9. Distribution mode is only instantaneous.

Some additional futures were added:
1. Pools can be marked to emit a signal when their value is changed.
2. End Conditions have a new parameter which is used just to send a signal when the condition is reached and do not terminate the execution of the diagram.

Gates are little be confusing to me right now cause there is no agreement between texts describing machinations and the software. For this reason gates are partial implemented. See Issues for more.

INSTALLATION:

Copy the addons folder to you Godot Engine folder and activate the Plugin from the Project Settings / Plugins

USAGE:

Add a GodotMation node to the scene the same way you are adding the engine's nodes.
When you select a GodotMation Node, in the tool bar ( the place output, debugger and etc can be found) a GodotMation button will appear. Click it to reveal the editor of the GodotMation.
You can load xml files (those are the xml files from Machination) or json file (created by GodotMation)
You can save to json files.
Play and stop playing the diagram inside the editor, to check the functionality.
And of course you can draw any diagram you may like.
Left mouse button is for selecting and placement of nodes and connections.
Right mouse button is used to pan the view.
Mouse wheel is used to zoom in zoom out from the diagram.

If you give an node a caption then the name of the child node under the GodotMation node will try to get this name. This way you can have access to the nodes and retrive their values or change them manualy. You can also use the emit siganl of the pools to connect functions that will give the values of the pool to your game object. You can also use the function of the nodes "change_input_state(value)" to add resources to your nodes or to connect the values of your game object with those of the godotmation nodes.

Please create an issue if something is not clear or if you think that a future is required.

Thanks.

P.S. GodotMation is written in GDScript, there is a parallel version written in Cpp : https://github.com/kakoeimon/GodotMationCpp


