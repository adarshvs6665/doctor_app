# doctor_app

`doctor_app` is a part of the Mental Health Analysis system. It is an app designed for doctors, allowing them to communicate with users and access their profiles and other relevant information.

The Mental Health Analysis system consists of two apps: `doctor_app` and `mental_health_analysis`. To use `doctor_app`, it is required to first install and configure the `mental_health_analysis_backend`.

## Mental Health Analysis System Repositories

- [Mental Health Analysis App Repository](https://github.com/adarshvs6665/mental_health_analysis)
- [Mental Health Analysis Backend Repository](https://github.com/adarshvs6665/mental_health_analysis_backend)

## Getting Started

To run the `doctor_app`, follow the steps below:

### Prerequisites

Before running the app, make sure you have Flutter installed on your system. If you haven't installed Flutter yet, you can do so by following the official Flutter installation guide.

### Running the Emulator

Launch the emulator using the following command:

flutter emulators --launch emulatorName


Make sure to replace `emulatorName` with the name of your desired emulator.

### Installing Dependencies

Run the following command to install all the necessary dependencies:

flutter pub get


### Configuring Backend URL

In the `constants.dart` file located in the app's source code, you will find a constant called `baseUrl`. This constant defines the connection URL of the backend. To connect to the locally hosted backend, please update the URL with your Wi-Fi IP address. Ensure that both the backend and the app are connected to the same Wi-Fi network.

### Running the App

Finally, run the app using the following command:

flutter run


This will start the `doctor_app` on the connected emulator or device.

## Support and Contact

If you encounter any issues or have any questions regarding the `doctor_app` or the Mental Health Analysis system, please feel free to contact us or open an issue in the respective GitHub repositories.

