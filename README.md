# Custom FD firmware for Seed Grove Vision AI Module 2
Custom face detection firmware developed using Himax WE2 SDK which aims to increase range and accuracy to be effective at over 2 meters.
## Major points
- Switched to using [Ultra-Light-Fast-Generic-Face-Detector-1MB](https://github.com/Linzaer/Ultra-Light-Fast-Generic-Face-Detector-1MB) model.
- Updated ARM and TensorFlow Lite for Microcontrollers to newest.
- Added ability to add custom libraries.
- Reworked memory management and communication functions.
## Project Structure
```
Seeed_Grove_Vision_AI_Module_V2    // Himax SDK root
  --EPII_CM55M_APP_S               // Firmware project
    --app
      --scenario_app
        --tflm_fd_1mb              // Custom firmware senario app
    --custom
      --library                    // Custom libraries
        --cmsis_nn                 // Custom updated ARM cmsis_nn library from ARM
        --inference
          --tflmtag2405_u55tag2405 // Custom updated TFLM library from ARM
  --images                         // Himax images
  --model_zoo                      // Himax example models
  --swd_debugging
  --we2_image_gen_local            // Firmware image generation tools
  --xmodem
```
