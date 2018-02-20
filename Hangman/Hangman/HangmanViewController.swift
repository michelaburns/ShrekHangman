//
//  HangmanViewController.swift
//  Hangman
//
//  Created by Michela on 2/19/18.
//  Copyright © 2018 iOS DeCal. All rights reserved.
//

import UIKit

class HangmanViewController: UIViewController,UITextFieldDelegate {

    // Items used throughout
    var answer = "";
    var guesses = [String]();
    var incorrectGuesses = [String]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        
        answer = phrase.uppercased();
        reviseCurrentWord(result: convertingAnswerToBlanks());
        currentGuess.delegate = self //Allows for the keyboard to later be put down when return is pressed
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func convertingAnswerToBlanks()->String{
        var result = ""
        for char in answer{
            //If there are separate words in answer
            if (char == " "){
                result += "  "
            }
            
            else if (!guesses.contains(String(char))){
                result += "_ "
            }
            else{
                result += String(char) + " "
            }
        }
        return result
    }
    
    //Changes the image based on how many incorrect guesses you make
    @IBOutlet weak var imageBox: UIImageView!
    func changeImageBox(){
        let num = incorrectGuesses.count
        if(num==0){
            imageBox.image = UIImage(named: "shrek1")
        }
        if(num<=6){
            let imgString: String = "shrek" + String(num+1)
            imageBox.image = UIImage(named: imgString)
        }
    }
    
    //Used to update the word you're guessing
    @IBOutlet weak var currentWord: UILabel!
    func reviseCurrentWord(result: String){
        self.currentWord.text = result
    }
    //Used to update the incorrect characters you've guessed
    @IBOutlet weak var wrongCharactersLabel: UILabel!
    func updateWrongCharactersLabel(){
        var result = "Incorrect Guesses ";
        for letter in incorrectGuesses{
            result += letter + " "
        }
        self.wrongCharactersLabel.text = result
    }
    
    //What happens when the "Guess" button is pressed
    @IBOutlet weak var currentGuess: UITextField!
    @IBAction func clickToGuess(_ sender: Any) {
        let guess:String = currentGuess.text ?? ""
        if(guess.count==1){
            if(guess != " " && !guesses.contains(guess.uppercased())){
                guesses.append(guess.uppercased())
                if(!answer.contains(guess.uppercased())){
                    incorrectGuesses.append(guess.uppercased())
                }
                reviseCurrentWord(result: convertingAnswerToBlanks())
                updateWrongCharactersLabel()
                changeImageBox()
                wordAccuracy()
            }
        }
    }
    
    //Makes the keyboard go away once return is press
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //When you guess the word correctly or run out of tries
    func wordAccuracy(){
        //If the word is accurate
        var guessMatches = true
        for char in answer{
            if char != " " && !guesses.contains(String(char)){
                guessMatches = false
            }
        }
        if(guessMatches){
            //print("Game Won")
            completedGameAlert(msg: "You won! Oh hello there!")
        }
        
        //If the word isn't accurate
        if(incorrectGuesses.count>=6){
            //print("Game Lost")
            completedGameAlert(msg: "You lost! Get out of my swamp!")
        }
    }
    
    
    func completedGameAlert(msg: String){
        let alertController = UIAlertController(title: msg, message:
            nil, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Play Again", style: UIAlertActionStyle.default,handler: startAgain))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func startAgain(alert: UIAlertAction!){
        let hangmanPhrases = HangmanPhrases()
        // Generate a random phrase for the user to guess
        let phrase: String = hangmanPhrases.getRandomPhrase()
        
        answer = phrase.uppercased();
        reviseCurrentWord(result: convertingAnswerToBlanks());
        
        guesses = [String]();
        incorrectGuesses = [String]();
        
        reviseCurrentWord(result: convertingAnswerToBlanks())
        updateWrongCharactersLabel()
        changeImageBox()
    }
    
    
}
