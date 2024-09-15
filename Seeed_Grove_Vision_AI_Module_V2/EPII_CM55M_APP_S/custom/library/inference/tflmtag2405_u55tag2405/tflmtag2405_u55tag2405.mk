# directory declaration
LIB_INFERENCE_ENGINE_DIR = $(LIBRARIES_ROOT)/inference/tflmtag2405_u55tag2405
LIB_INFERENCE_ENGINE_DEFINES = -DTFLM2405_U55TAG2405

# use for information only rules.mk - ALL_ASMSRC_DIRS
LIB_INFERENCE_ENGINE_ASMSRCDIR	= $(LIB_INFERENCE_ENGINE_DIR)
LIB_INFERENCE_ENGINE_CSRCDIR	= $(LIB_INFERENCE_ENGINE_DIR) 
LIB_INFERENCE_ENGINE_CXXSRCSDIR    = $(LIB_INFERENCE_ENGINE_DIR)

# LIB_INFERENCE_ENGINE_INCDIR (needed) used in files.mk - INCS_DIR 
# add into ALL_INCLUDES = $(foreach dir,$(ALL_INC_DIRS),-I$(dir)) in rules.mk
# INCS_DIR		= $(OS_INCDIR) $(BOARD_INCDIR) $(LIB_INCDIR) $(BOARD_INC_DIR) $(DEVICE_INC_DIR) $(DRIVERS_INCDIR) $(EXTERNAL_INCDIR) $(LIB_BSS_DATA_INCDIR) \
				$(TRUSTZONE_SEC_INC_DIR) $(TRUSTZONE_CFG_INC_DIR) $(NSC_INC_DIR) $(MID_INCDIR) $(LIB_INFERENCE_ENGINE_INCDIR) $(LIB_AUDIOALGO_INCDIR) $(HWACCAUTOTEST_INCDIR)\
				$(SCENARIO_APP_INCDIR) $(LINKER_INC_DIR) 
# Linux command: find . -type f | grep tensor | grep '\.h' | grep -v test | grep -v cmsis_nn | grep -v experimental | sed 's@\/[a-z|A-Z|-|_|0-9]*\..*@ \\@' | sort | uniq
LIB_INFERENCE_ENGINE_INCDIR	= \
$(LIB_INFERENCE_ENGINE_DIR) \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/c \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/api \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/c \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/optimized \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/reference \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/reference/integer_ops \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arena_allocator \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/memory_planner \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tflite_bridge \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/schema \

#$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/dtln \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/micro_speech \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/benchmarks \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/benchmarking \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/gen_micro_mutable_op_resolver/templates \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/cortex_m_generic \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/hifimini \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/python/interpreter/src \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/python/tflite_size/src \

# Linux command: find . -type f | grep core_driver | grep '\.h' | grep -v test | grep -v cmsis_nn | grep -v experimental | sed 's@\/[a-z|A-Z|-|_|0-9]*\..*@ \\@' | sort | uniq
LIB_INFERENCE_ENGINE_INCDIR += \
$(LIB_INFERENCE_ENGINE_DIR)/core_driver/include \
$(LIB_INFERENCE_ENGINE_DIR)/core_driver/src \

# Linux command: find . -type f | grep third_party | grep '\.h' | grep -v test | grep -v cmsis_nn | grep -v experimental | sed 's@\/[a-z|A-Z|-|_|0-9]*\..*@ \\@' | sort | uniq
LIB_INFERENCE_ENGINE_INCDIR += \
$(LIB_INFERENCE_ENGINE_DIR)/third_party \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers/include \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/gemmlowp \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/hexagon \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/kissfft \
$(LIB_INFERENCE_ENGINE_DIR)/third_party/ruy

#$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers/include/flatbuffers/pch \
#	$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers/include/flatbuffers \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers/src \

#$(LIB_INFERENCE_ENGINE_DIR)third_party/kissfft/tools \

#$(LIB_INFERENCE_ENGINE_DIR)third_party/ruy/ruy/profiler \
#$(LIB_INFERENCE_ENGINE_DIR)third_party/xtensa/examples/micro_speech_lstm \
#$(LIB_INFERENCE_ENGINE_DIR)third_party/xtensa/examples/pytorch_to_tflite \

#$(LIB_INFERENCE_ENGINE_DIR)/third_party \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/flatbuffers/include \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/gemmlowp \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/gemmlowp/fixedpoint \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/hexagon \
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/ruy
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/kissfft
#$(LIB_INFERENCE_ENGINE_DIR)/third_party/gemmlowp/internal \

LIB_INFERENCE_ENGINE_INCDIR += \
$(LIB_INFERENCE_ENGINE_DIR)/signal
#$(LIB_INFERENCE_ENGINE_DIR)/signal/micro/kernels \
#$(LIB_INFERENCE_ENGINE_DIR)/signal/src \
#$(LIB_INFERENCE_ENGINE_DIR)/signal/src/kiss_fft_wrappers \


# find all the source files in the target directories
#LIB_INFERENCE_ENGINE_CSRCS = $(call get_csrcs, $(LIB_INFERENCE_ENGINE_CSRCDIR))
# LIB_INFERENCE_ENGINE_CSRCS = $(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/c/common.c

LIB_INFERENCE_ENGINE_CSRCS = \
$(LIB_INFERENCE_ENGINE_DIR)/core_driver/src/ethosu_pmu.c \
$(LIB_INFERENCE_ENGINE_DIR)/core_driver/src/ethosu_driver.c \
$(LIB_INFERENCE_ENGINE_DIR)/core_driver/src/ethosu_device_u55_u65.c

#LIB_INFERENCE_ENGINE_CXXSRCS = $(call get_cxxsrcs, $(LIB_INFERENCE_ENGINE_CXXSRCSDIR))

LIB_INFERENCE_ENGINE_CXXSRCS = \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/api/error_reporter.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/api/flatbuffer_conversions.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/api/tensor_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/core/c/common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/portable_tensor_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/quantization_util.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/reference/comparisons.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/reference/portable_tensor_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/runtime_shape.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/tensor_ctypes.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/internal/tensor_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/kernels/kernel_util.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arena_allocator/non_persistent_arena_buffer_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arena_allocator/persistent_arena_buffer_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arena_allocator/recording_single_arena_buffer_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arena_allocator/single_arena_buffer_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/debug_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/fake_micro_context.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/flatbuffer_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/activations.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/activations_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/add.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/add_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/add_n.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arg_min_max.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/assign_variable.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/batch_matmul.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/batch_to_space_nd.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/broadcast_args.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/broadcast_to.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/call_once.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cast.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceil.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/circular_buffer.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/circular_buffer_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/circular_buffer_flexbuffers_generated_data.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/comparisons.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/concatenation.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/conv_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cumsum.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/depth_to_space.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/depthwise_conv_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/dequantize.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/dequantize_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/detection_postprocess.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/detection_postprocess_flexbuffers_generated_data.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/div.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/elementwise.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/elu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/embedding_lookup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ethosu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ethos_u/ethosu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/expand_dims.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/exp.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/fill.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/floor.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/floor_div.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/floor_mod.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/fully_connected_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/gather.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/gather_nd.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/hard_swish.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/hard_swish_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/if.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/kernel_runner.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/kernel_util.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/l2norm.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/l2_pool_2d.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/leaky_relu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/leaky_relu_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/logical.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/logical_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/logistic.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/logistic_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/log_softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/lstm_eval.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/lstm_eval_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/maximum_minimum.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/micro_tensor_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/mirror_pad.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/mul.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/mul_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/neg.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/pack.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/pad.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/pooling.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/pooling_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/prelu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/prelu_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/quantize.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/quantize_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/read_variable.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/reduce.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/reduce_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/reshape.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/reshape_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/resize_bilinear.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/resize_nearest_neighbor.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/round.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/select.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/shape.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/slice.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/softmax_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/space_to_batch_nd.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/space_to_depth.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/split.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/split_v.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/squared_difference.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/squeeze.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/strided_slice.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/strided_slice_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/sub.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/sub_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/svdf.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/svdf_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/tanh.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/transpose.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/transpose_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/unidirectional_sequence_lstm.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/unpack.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/var_handle.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/while.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/zeros_like.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/memory_helpers.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/memory_planner/greedy_memory_planner.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/memory_planner/linear_memory_planner.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/memory_planner/non_persistent_buffer_planner_shim.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_allocation_info.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_context.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_interpreter.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_interpreter_context.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_interpreter_graph.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_op_resolver.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_profiler.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_resource_variable.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/micro_utils.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/mock_micro_graph.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/recording_micro_allocator.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/system_setup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tflite_bridge/flatbuffer_conversions_bridge.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tflite_bridge/micro_error_reporter.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/schema/schema_utils.cc

#$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/array.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/dtln/dtln_inout_data.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/memory_footprint/baseline_memory_footprint.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/memory_footprint/interpreter_memory_footprint.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection/detection_responder.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection/image_provider.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection/main.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection/main_functions.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/examples/person_detection/model_settings.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/benchmarks/keyword_benchmark_8bit.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/benchmarks/keyword_benchmark.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/benchmarks/person_detection_benchmark.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arc_custom/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arc_custom/system_setup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/arc_emsdp/debug_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/add.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/mli_interface.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/mli_interface_mli_20.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/mli_slicers.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/pooling.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/scratch_buffers.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/arc_mli/scratch_buf_mgr.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/ceva/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/ceva/system_setup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/ceva_common.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/logistic.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/quantize.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/ceva/softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/bluepill/debug_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/chre/debug_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/cortex_m_corstone_300/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/cortex_m_corstone_300/system_setup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/cortex_m_generic/debug_log.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/cortex_m_generic/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/hexagon/micro_time.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/hexagon/system_setup.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/add.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/add_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_common_xtensa.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_hifi.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_int16_reference.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_int8_int16.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_int8_reference.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/conv_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_hifi.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/depthwise_conv_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/dequantize.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/fully_connected_common_xtensa.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/fully_connected_int8.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/fully_connected_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/hifimini/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/hifimini/svdf.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/leaky_relu.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/logistic.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/lstm_eval.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/lstm_eval_hifi.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/pad.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/pad_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/pooling.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/pooling_int8.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/pooling_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/quantize.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/reduce.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/reduce_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/reshape.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/reshape_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/softmax_int8_int16.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/softmax_vision.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/strided_slice.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/sub.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/svdf.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/transpose_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/xtensa/unidirectional_sequence_lstm.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/benchmarking/generic_model_benchmark.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/benchmarking/metrics.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/benchmarking/show_meta_data.cc.template \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/layer_by_layer.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/tools/tflite_flatbuffer_align_wrapper.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/python/tflite_size/src/flatbuffer_size_wrapper_pybind.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/riscv32_generic/debug_log.cc \

ifeq ($(LIB_CMSIS_NN_ENALBE), 1)
LIB_INFERENCE_ENGINE_CXXSRCS += \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/add.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/mul.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/pooling.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/cmsis_nn/svdf.cc 

LIB_INFERENCE_ENGINE_DEFINES += -DCMSIS_NN

else
#if not use cmsis nn, unmask the function below and mask cmsis nn related information 
LIB_INFERENCE_ENGINE_CXXSRCS +=  \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/add.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/depthwise_conv.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/fully_connected.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/mul.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/pooling.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/softmax.cc \
$(LIB_INFERENCE_ENGINE_DIR)/tensorflow/lite/micro/kernels/svdf.cc 
endif

#LIB_INFERENCE_ENGINE_ASMSRCS = $(call get_asmsrcs, $(LIB_INFERENCE_ENGINE_ASMSRCDIR))
LIB_INFERENCE_ENGINE_ASMSRCS = 

#needed by elf build
# get object files, needed by files.mk
LIB_INFERENCE_ENGINE_COBJS = $(call get_relobjs, $(LIB_INFERENCE_ENGINE_CSRCS))
LIB_INFERENCE_ENGINE_CXXOBJS = $(call get_relobjs, $(LIB_INFERENCE_ENGINE_CXXSRCS))
LIB_INFERENCE_ENGINE_ASMOBJS = $(call get_relobjs, $(LIB_INFERENCE_ENGINE_ASMSRCS))


LIB_INFERENCE_ENGINE_OBJS = $(LIB_INFERENCE_ENGINE_COBJS) $(LIB_INFERENCE_ENGINE_ASMOBJS) $(LIB_INFERENCE_ENGINE_CXXOBJS)

# get dependency files
LIB_INFERENCE_ENGINE_DEPS = $(call get_deps, $(LIB_INFERENCE_ENGINE_OBJS))

# extra macros to be defined
LIB_INFERENCE_ENGINE_DEFINES += -DTF_LITE_STATIC_MEMORY -DTF_LITE_MCU_DEBUG_LOG  
LIB_INFERENCE_ENGINE_DEFINES += -DETHOSU_ARCH=u55 -DETHOSU55 -DETHOSU_LOG_SEVERITY=ETHOSU_LOG_WARN -DETHOS_U

# genearte library
ifeq ($(LIB_CMSIS_NN_ENALBE), 1)
INFERENCE_ENGINE_LIB_NAME = libtflmtag2405_u55tag2405_cmsisnn_$(TOOLCHAIN).a
lib_sel += cmsis_nn
else
INFERENCE_ENGINE_LIB_NAME = libtflmtag2405_u55tag2405_$(TOOLCHAIN).a
endif

# Middleware Definitions
INFERENCE_ENGINE_LIB_CSRCDIR += $(LIB_INFERENCE_ENGINE_CSRCDIR)
INFERENCE_ENGINE_LIB_CXXSRCDIR += $(LIB_INFERENCE_ENGINE_CXXSRCDIR)
INFERENCE_ENGINE_LIB_ASMSRCDIR += $(LIB_INFERENCE_ENGINE_ASMSRCDIR)

# definition only exist in inference_engine 
#INFERENCE_ENGINE_LIB_CSRCS += $(LIB_INFERENCE_ENGINE_CSRCS)
#INFERENCE_ENGINE_LIB_CXXSRCS += $(LIB_INFERENCE_ENGINE_CXXSRCS)
#INFERENCE_ENGINE_LIB_ASMSRCS += $(LIB_INFERENCE_ENGINE_ASMSRCS)
#INFERENCE_ENGINE_LIB_ALLSRCS += $(LIB_INFERENCE_ENGINE_CSRCS) $(LIB_INFERENCE_ENGINE_ASMSRCS)


INFERENCE_ENGINE_LIB_COBJS += $(LIB_INFERENCE_ENGINE_COBJS)
INFERENCE_ENGINE_LIB_CXXOBJS += $(LIB_INFERENCE_ENGINE_CXXOBJS)
INFERENCE_ENGINE_LIB_ASMOBJS += $(LIB_INFERENCE_ENGINE_ASMOBJS)
INFERENCE_ENGINE_LIB_ALLOBJS += $(LIB_INFERENCE_ENGINE_OBJS)

LIB_DEFINES += $(LIB_INFERENCE_ENGINE_DEFINES)
LIB_DEPS += $(LIB_INFERENCE_ENGINE_DEPS)
# INFERENCE_ENGINE_LIB_LIBS += $(LIB_LIB_INFERENCE_ENGINE)

# library generation rule
ifeq ($(INFERENCE_FORCE_PREBUILT), y)
override LIB_INFERENCE_ENGINE_OBJS:=
endif

INFERENCE_ENGINE_LIB := $(subst /,$(PS), $(strip $(OUT_DIR)/$(INFERENCE_ENGINE_LIB_NAME)))

# library generation rule
$(INFERENCE_ENGINE_LIB): $(LIB_INFERENCE_ENGINE_OBJS)
	$(TRACE_ARCHIVE)
ifeq "$(strip $(LIB_INFERENCE_ENGINE_OBJS))" ""
	$(CP) $(PREBUILT_LIB)$(INFERENCE_ENGINE_LIB_NAME) $(INFERENCE_ENGINE_LIB)
else
	$(Q)$(AR) $(AR_OPT) $@ $(LIB_INFERENCE_ENGINE_OBJS)
	$(CP) $(INFERENCE_ENGINE_LIB) $(PREBUILT_LIB)$(INFERENCE_ENGINE_LIB_NAME)
endif

