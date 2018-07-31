import AVCaptureDevice
import UIKit

class ImageSelection: NSObject {
    func didTapProfileImage() {
        let topMostViewController = ApplicationManager.shared.topMostViewController

        let takePhotoAlertAction = UIAlertAction(
            title: NSLocalizedString("Take Photo", comment: "Add profile picture alert take photo action"),
            style: .default
        ) { [unowned self] _ in
            let authorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)

            if UIImagePickerController.isSourceTypeAvailable(.camera),
                authorizationStatus != .denied && authorizationStatus != .restricted {
                self.imagePicker.sourceType = .camera
                topMostViewController.present(self.imagePicker, animated: true, completion: nil)
            } else {
                topMostViewController.presentAlert(
                    title: "Access to camera is disabled. Enable it in the Settings application",
                    actions: [
                        UIAlertAction(
                            title: NSLocalizedString("Settings", comment: "Add profile picture no camera alert settings action"),
                            style: .default
                        ) { _ in
                            guard let url = URL(string: UIApplicationOpenSettingsURLString) else { return }

                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        },
                        UIAlertAction(
                            title: NSLocalizedString("Cancel", comment: "Add profile picture no camera alert cancel action"),
                            style: .cancel
                        )
                    ]
                )
            }
        }

        let choseFromLibraryAlertAction = UIAlertAction(
            title: NSLocalizedString("Choose From Library", comment: "Add profile picture alert choose from library action"),
            style: .default
        ) { [unowned self] _ in
            self.imagePicker.sourceType = .photoLibrary
            topMostViewController.present(self.imagePicker, animated: true, completion: nil)
        }

        let cancelAlertAction = UIAlertAction(
            title: NSLocalizedString("Cancel", comment: "Add profile picture alert cancel action"),
            style: .cancel
        )

        topMostViewController.presentAlert(
            title: NSLocalizedString("Add Profile Photo", comment: "Add profile picture alert title"),
            actions: [takePhotoAlertAction, choseFromLibraryAlertAction, cancelAlertAction]
        )
    }
}

extension ImageSelection: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        imagePicker.dismiss(animated: true, completion: nil)

        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }

        // TODO: store image
        //        ApplicationManager.shared.update(state: .game)
    }
}
