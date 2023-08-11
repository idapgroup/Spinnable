# Spinnable

## Description

Spinnable is an extension for UIView and UIViewController, which allows you to conveniently organize work with a spinner implemented in this extension by default or customized by the user.

## Usage example

The following code snippet shows a basic use of the SpinnableAddon, for example when loading data from the web:

```swift
import UIKit
import Spinnable

class ViewController: UIViewController, Spinnable {
    
    typealias SpinnerType = SpinnerView  // Spinnable requirement: in this typealias, a type substitution takes place that satisfies
                                         // the requirements of the Spinner protocol (an example implementation is given below)
    
    var isLoaded: Bool = false           // Spinnable requirement: this property is an indicator
                                         // of whether data is being loaded at this moment.
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getDataFromNetwork()
    }
    
    private func getDataFromNetwork() {
        self.showSpinner()    // Set a spinner for the duration of a network request
        
        let url = ...
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                // ... Your code for processing data and responce from the server
                self.hideSpinner()  // Hide the spinner when a response is received from the server. We do it ON THE MAIN THREAD
            }
        }
        
        task.resume()
    }
}
```

The overloaded version of the `showSpinner(on:configure:)` function allows you to explicitly specify the view on which the spinner will be displayed and have access to the spinner directly at the moment it is displayed

An example implementation of a view that satisfies the requirements of the Spinner protocol:

```swift
public class SpinnerView: Spinner {
    
    public static func preparedSpinner() -> UIView {
        let bg = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        bg.backgroundColor = .clear
        let plate = UIView(frame: .init(x: 0, y: 0, width: 100, height: 100))
        plate.backgroundColor = .systemGray6
        plate.idp_cornerRadius = 10
        let indicator = UIActivityIndicatorView(style: .large)
        
        bg.addSubview(plate)
        plate.addSubview(indicator)
        
        self.addCenteredConstraint(view: plate, superview: bg, heightOffset: -40)
        self.addCenteredConstraint(view: indicator, superview: plate)
        
        indicator.startAnimating()
        
        return bg
    }
    
    private static func addCenteredConstraint(
        view: UIView,
        superview: UIView,
        heightOffset: CGFloat = 0
    ) {
        view.translatesAutoresizingMaskIntoConstraints = false
        let horizontalConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor)
        let verticalConstraint = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: heightOffset)
        let widthConstraint = view.widthAnchor.constraint(equalToConstant: 100)
        let heightConstraint = view.heightAnchor.constraint(equalToConstant: 100)
        
        NSLayoutConstraint.activate([horizontalConstraint, verticalConstraint, widthConstraint, heightConstraint])
    }
}
```

## Requirements

iOS 9+, Swift 3.0

## Installation

Spinnable is available through CocoaPods. To install it, simply add the following line to your Podfile:

```javascript copy
pod "Spinnable"
```

SpinnableAdn is available through Carthage. To install it, simply add the following line to your Cartfile:

```javascript copy
github "idapgroup/Spinnable"
```


## License

Spinnable is available under the New BSD license. See the LICENSE file for more info.
