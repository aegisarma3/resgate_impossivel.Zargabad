
// Muda as cores
"ColorCorrections" ppEffectEnable true;
"ColorCorrections" ppEffectAdjust [ 1, 1.08, -0.06, [ 0.5, 0.5, 0.5, 0 ], [ 1.0, 1.0, 1.0, 1.21 ], [ 0.09, 0.09, 0.09, 0.0 ] ];
"ColorCorrections" ppEffectCommit 0;

playMusic "rescue";

titleText [ "", "BLACK FADED", 5 ];
0 fadeSound 0;
0 fadeMusic 0;
0 fadeSpeech 0;
enableRadio false;
enableEnvironment false;
clearRadio;



5 fadeSound 1;
5 fadeMusic 0.4;
5 fadeSpeech 1;
enableRadio true;
enableEnvironment true;



private [ "_year", "_month", "_day", "_hour", "_minute", "_date", "_time" ];

_year = ( date select 0 );
_month = ( date select 1 );
_day = ( date select 2 );

if( _month < 10 ) then { _month = format[ "0%1", _month ] };
if( _day < 10 ) then { _day = format[ "0%1", _day ] };


_date = format[ "%1-%2-%3", _day, _month, _year ];

_hour = ( date select 3 );
_minute = ( date select 4 );

if( _hour < 10 ) then { _hour = format[ "0%1", _hour ] };
if( _minute < 10 ) then { _minute = format[ "0%1", _minute ] };


_time = format[ "%1:%2", _hour, _minute ];

[  
	[ 

		[ _date, "<t size='1.0' font='PuristaMedium'>%1</t>", 0 ], 
		[ _time, "<t size='1.0' font='PuristaBold'>%1</t><br/>", 5 ], 

		[ "Sul de Shahabaz", "<t size='0.9' font='PuristaBold'>%1</t><br/>", 5 ], 

		[ "Zargabad", "<t size='0.9'>%1</t><br/>", 30 ]


	],
	-safezoneX, 
	0.85, 
	"<t align='right' shadow='1' size='1.0'>%1</t>" 
] spawn BIS_fnc_typeText;


