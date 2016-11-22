%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).



participantJuriFans([], _, []).
participantJuriFans([Time|Times], JuriId, JuriFans) :-
	Time = 120,
	JuriId1 is JuriId + 1,
	participantJuriFans(Times, JuriId1, JuriFansTemp),
	append([JuriId], JuriFansTemp, JuriFans).
participantJuriFans([Time|Times], JuriId, JuriFans) :-
	Time \= 120,
	JuriId1 is JuriId + 1,
	participantJuriFans(Times, JuriId1, JuriFans).


juriFansAux([], []).
juriFansAux([Participant|Participants], JuriFansList) :-
	performance(Participant, Times),
	participantJuriFans(Times, 1, Fans),
	juriFansAux(Participants, JuriFansListTemp),
	append([Participant-Fans], JuriFansListTemp, JuriFansList).


juriFans(JuriFansList) :-
	findall(Participant, performance(Participant, _), Participants),
	juriFansAux(Participants, JuriFansList).
