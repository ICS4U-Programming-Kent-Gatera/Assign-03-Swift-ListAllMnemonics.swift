import Foundation

/**

* Describe what your program does.

*
* @author  Kent Gatera
* @version 1.0
* @since   2024-May-14
*/
// MnemonicsCombos class
final class MnemonicsCombos {

    static func main() {
        let inputFile = URL(fileURLWithPath: "input.txt")
        let outputFile = URL(fileURLWithPath: "output.txt")
        var mnemonicsOutputList = [String]()

        // Dictionary for Mnemonics
        var lettersForDigitDictionary = [String: String]()
        lettersForDigitDictionary["1"] = " "
        lettersForDigitDictionary["2"] = "ABC"
        lettersForDigitDictionary["3"] = "DEF"
        lettersForDigitDictionary["4"] = "GHI"
        lettersForDigitDictionary["5"] = "JKL"
        lettersForDigitDictionary["6"] = "MNO"
        lettersForDigitDictionary["7"] = "PQRS"
        lettersForDigitDictionary["8"] = "TUV"
        lettersForDigitDictionary["9"] = "WXYZ"
        lettersForDigitDictionary["0"] = " "



        // User choice for extra functionality.
        print("\t\t\tListAllMnemonics Assign-03 Swift \n\tThis pro will list all of a number's possible mnemonics.\n \t\t\t\ti.e: 343")
        print("\n\t\t Press 1 (console)\t Press 2 (Input file).")
        let userChoice = readLine()
        if (userChoice == "2") {
            do {
                // Getting/reading the input file.
                let inputString = try String(contentsOf: inputFile)
                let mnemonicNums = inputString.components(separatedBy: .newlines)
                var errorLineIter = 1
                var outputString = ""

                for mnemonic in mnemonicNums {
                    // Making sure the list is clear.
                    mnemonicsOutputList.removeAll()
                    // Create list of all Mnemonic results
                    let result = ListAllMnemonics(mnemonic, mnemonicsOutputList, lettersForDigitDictionary)
                    outputString += "\(mnemonic): \(result)\n"
                    errorLineIter += 1
                    
                }
                try outputString.write(to: outputFile, atomically: true, encoding: .utf8)
                
                print("Done.")
            } catch {
                print("Invalid input path!")
            }
        } else if (userChoice == "1") {
            do {
                print("Enter the mnemonic: ", terminator: "")
                let mnemonic = readLine()!
                // Making sure the list is clear.
                mnemonicsOutputList.removeAll()
                // Create list of all Mnemonic results
                let result = ListAllMnemonics(mnemonic, mnemonicsOutputList, lettersForDigitDictionary)
                let outputString = "\(mnemonic): \(result)\n"
                try outputString.write(to: outputFile, atomically: true, encoding: .utf8)
            } catch {
                print("Error in outputString.")
            }
        }
        print("Done.")
        }
    }

    // Recursive method that gets the MnemonicsCombos of a number.
    func ListAllMnemonics(_ someNumString: String, _ mnemonicsOutputList: [String], _ alphNumMap: [String: String]) -> [String] {
        if someNumString.isEmpty {
            // Returning an empty list to prevent errors.
            return [""]
        } else {
            // Creating the list where the finished combinations go.
            var mnemonicsCombos = [String]()

            let currentNumFromString = someNumString.first!
            // If the letter does not register in the dictionary, return an empty value.
            guard let dictDefinition = alphNumMap[String(currentNumFromString)] else { return [] }

            for frontLetter in dictDefinition {
                // For each of those characters in the string, we add them to a list of all
                // possible combinations.
                let listOfSuffixes = ListAllMnemonics(String(someNumString.dropFirst()), mnemonicsCombos, alphNumMap)
                for suffixCombination in listOfSuffixes {
                    let newValue = String(frontLetter) + suffixCombination
                    mnemonicsCombos.append(newValue)
                }
            }
            return mnemonicsCombos
        }
    }


// Call the main method
    MnemonicsCombos.main()