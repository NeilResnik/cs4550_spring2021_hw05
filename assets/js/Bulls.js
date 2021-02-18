import 'bulma/css/bulma.css'
import React, { useState, useEffect } from 'react';
import { GuessInput } from './game'
import { ch_join } from './socket'

function Bulls() {
    const [gameState, setGameState] = useState({
        guesses: [],
        results: [],
    });

    useEffect(() => {
        ch_join(setGameState);
    });

    let notificationClassName = "notification";
    if(gameState.correct) {
        notificationClassName += " is-primary";
    } else if(gameState.guesses.length >= 8){
        notificationClassName += " is-danger";
    } else {
        notificationClassName += " is-hidden";
    }

    return (
        <div className="Bulls">
           <section className="section">
               <div className="container has-text-centered">
                    <div className={notificationClassName}>
                        <p>{gameState.correct ? "You Won!" : "You Lost!"}</p>
                        <p> Correct Answer: {gameState.secret}</p>
                    </div>
                   <GuessInput enabled={gameState.results[0] !== "4A0B" && gameState.guesses.length < 8}/>
                    <p className="is-size-3">Lives: {8 - gameState.guesses.length}</p>
               </div>
           </section>
           <section className="section">
               <div className="container has-text-centered">
                   <h1 className="title is-size-2">Guesses:</h1>
                       <ul>
                           {gameState.guesses.map(function(e, i){
                               return (
                                   <li key={e}>
                                       <p>{e}: {gameState.results[i]}</p>
                                   </li>
                               );
                           })}
                       </ul>
               </div>
           </section>
        </div>
    );
}

export default Bulls;
