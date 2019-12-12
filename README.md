# advancedWarsMobile

References 
  - We took our sprites from Advanced Wars and Advanced Wars 2
  - We took the background music from Advanced Wars and Advanced Wars 2

Instructions
  - Advanced Wars is a turn based tactic game for game boy. 
  - The objective of the game is to beat the enemy army. To win, you must attack each other until there is only one team standing. Each team takes turn moving their army around the map. Each army has 4 types of units: Mech, Infantry, Tank and Recon, each have their strengths and weaknesses in terms of attack, defence, HP and mobility. 
  - To move your army, you press one of your units and the ground will highlight on where the unit can move to. Once you move your desired number of units, to end the turn you must long press a section of the map and hit end. This ends the day and your turn. Now it is the other armys turn to move. 
  - If units from the different armies are near eachother, they are in striking distance. To attack, you must move to an area near them, a menu will appear asking you to either fire, wait or cancel. Once you choose fire, a snackbar will appear updating that you have attacked, the HP indicator will update near the sprites. 
  - The goal is to survive the war until one army remains

Known Bugs
  - Music throws errors that don't break
  - Menu sometimes appears on opposite sides of gesture detector
  - On certain screens, hitting the back button on your phone can cause app to crash
  - Attack highlighting and day turn animation does not get updated with setstate() every time
