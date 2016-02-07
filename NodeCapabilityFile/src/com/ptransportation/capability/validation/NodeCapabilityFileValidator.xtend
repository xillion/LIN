/*
 * generated by Xtext 2.9.1
 */
package com.ptransportation.capability.validation

import com.ptransportation.capability.nodeCapabilityFile.ArraySignalValue
import com.ptransportation.capability.nodeCapabilityFile.AutomaticBitrate
import com.ptransportation.capability.nodeCapabilityFile.FixedBitrate
import com.ptransportation.capability.nodeCapabilityFile.Frame
import com.ptransportation.capability.nodeCapabilityFile.NadList
import com.ptransportation.capability.nodeCapabilityFile.NadRange
import com.ptransportation.capability.nodeCapabilityFile.Node
import com.ptransportation.capability.nodeCapabilityFile.NodeCapabilityFile
import com.ptransportation.capability.nodeCapabilityFile.NodeCapabilityFilePackage
import com.ptransportation.capability.nodeCapabilityFile.ScalorSignalValue
import com.ptransportation.capability.nodeCapabilityFile.SelectBitrate
import com.ptransportation.capability.nodeCapabilityFile.Signal
import com.ptransportation.capability.nodeCapabilityFile.Slave
import java.util.HashSet
import org.eclipse.xtext.validation.Check

/**
 * This class contains custom validation rules. 
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#validation
 */
class NodeCapabilityFileValidator extends AbstractNodeCapabilityFileValidator {
	public static val LIN_VERSIONS = #['1.0','1.1','1.2', '1.3','2.0','2.1','2.2'];
	
	@Check
	def checkThatTheProtocalVersionIsAValidLINVersion(Node node) {
		if(!LIN_VERSIONS.contains(node.protocolVersion)) {
			error('''Invalid LIN protocol version "«node.protocolVersion»".''',node,
				NodeCapabilityFilePackage.Literals.NODE__PROTOCOL_VERSION
			);
		}
		if(!node.protocolVersion.equals('2.2')) {
			warning('''Currently only LIN protocol version "2.2" is supported.''',node,
				NodeCapabilityFilePackage.Literals.NODE__PROTOCOL_VERSION
			);
		}
	}
	
	@Check
	def checkThatTheLanguageVersionIsAValidLINVersion(NodeCapabilityFile file) {
		if(!LIN_VERSIONS.contains(file.languageVersion)) {
			error('''Invalid LIN language version "«file.languageVersion»".''',file,
				NodeCapabilityFilePackage.Literals.NODE_CAPABILITY_FILE__LANGUAGE_VERSION
			);
		}
		if(!file.languageVersion.equals('2.2')) {
			warning('''Currently only LIN language version "2.2" is supported.''',file,
				NodeCapabilityFilePackage.Literals.NODE_CAPABILITY_FILE__LANGUAGE_VERSION
			);
		}
	}
	
	@Check
	def checkThatTheSupplierIDWillFitInA16bitInteger(Node node) {
		val v = Integer.decode(node.supplier);
		if(v < 0 || v > 0xFFFF) {
			error('''Invalid supplier ID "«node.supplier»". The supplier ID must be in the range [0x0000,0xFFFF].''',node,
				NodeCapabilityFilePackage.Literals.NODE__SUPPLIER
			);
		}
	}
	
	@Check
	def checkThatTheFunctionIDWillFitInA16bitInteger(Node node) {
		val v = Integer.decode(node.function);
		if(v < 0 || v > 0xFFFF) {
			error('''Invalid function ID "«node.function»". The function ID must be in the range [0x0000,0xFFFF].''',node,
				NodeCapabilityFilePackage.Literals.NODE__FUNCTION
			);
		}
	}
	
	@Check
	def checkThatTheVariantIDWillFitInA16bitInteger(Node node) {
		val v = Integer.decode(node.variant);
		if(v < 0 || v > 0xFF) {
			error('''Invalid variant ID "«node.variant»". The variant ID must be in the range [0x00,0xFF].''',node,
				NodeCapabilityFilePackage.Literals.NODE__VARIANT
			);
		}
	}
	
	@Check
	def checkThatDiagnosticClassIsOneTwoOrThree(Slave slave) {
		val v = Integer.decode(slave.diagnosticClass);
		if(v != 1 && v != 2 && v != 3) {
			error('''Invalid diagnostic class "«slave.diagnosticClass»". The the diagnostic class must be 1, 2, or 3.''',slave,
				NodeCapabilityFilePackage.Literals.SLAVE__DIAGNOSTIC_CLASS
			);
		}
	}
	
	
	@Check
	def warnAboutP2MinNotBeingUsed(Slave node) {
		if(node.p2Min == null)
			return;
		warning('''The current implementation does not take this value in to account.''',node,
			NodeCapabilityFilePackage.Literals.SLAVE__P2_MIN
		)
	}
	
	@Check
	def warnAboutSTMinNotBeingUsed(Slave node) {
		if(node.stMin == null)
			return;
		warning('''The current implementation does not take this value in to account.''',node,
			NodeCapabilityFilePackage.Literals.SLAVE__ST_MIN
		)
	}
	
	@Check
	def warnAboutNAsTimeoutMinNotBeingUsed(Slave node) {
		if(node.NAsTimeout == null)
			return;
		warning('''The current implementation does not take this value in to account.''',node,
			NodeCapabilityFilePackage.Literals.SLAVE__NAS_TIMEOUT
		)
	}
	
	@Check
	def warnAboutNCrTimeoutMinNotBeingUsed(Slave node) {
		if(node.NCrTimeout == null)
			return;
		warning('''The current implementation does not take this value in to account.''',node,
			NodeCapabilityFilePackage.Literals.SLAVE__NCR_TIMEOUT
		)
	}
	
	@Check
	def checkThatTheSupportedServiceIdentifiersAreInRange(Slave node) {
		if(node.supportedSIDS == null)
			return;
		node.supportedSIDS.forEach[
			val v = Integer.decode(it);
			if(v < 0 || v > 0xFF) {
				error('''Invalid service ID "«it»". The service ID must be in the range [0x00,0xFF].''',node,
				NodeCapabilityFilePackage.Literals.SLAVE__SUPPORTED_SIDS,
				node.supportedSIDS.indexOf(it));
			}
		]
	}
	
	@Check
	def checkThatTheMaxMessageLengthIsInRange(Slave node) {
		if(node.maxMessageLength == null)
			return;
		val v = Integer.decode(node.maxMessageLength);
		if(v < 0 || v > 0xFFFF) {
			error('''Invalid max message length "«node.maxMessageLength»". The message lenght must be in the range [0x0000,0xFFFF].''',node,
				NodeCapabilityFilePackage.Literals.SLAVE__MAX_MESSAGE_LENGTH
			);
		}
	}
	
	@Check
	def checkThatTheLengthOfTheFrameIsOneToEight(Frame frame) {
		val v = Integer.decode(frame.length);
		if(v < 1 || v > 8) {
			error('''Invalid frame length"«frame.length»". The frame length must in the range [1,8].''',frame,
				NodeCapabilityFilePackage.Literals.FRAME__LENGTH
			);
		}
	}
	
	@Check
	def warnAboutFrameMinPriodBeingUsed(Frame frame) {
		if(frame.minPeriod == null)
			return;
		warning('''The current implementation does not take this value in to account.''',frame,
			NodeCapabilityFilePackage.Literals.FRAME__MIN_PERIOD
		)
	}
	
	@Check
	def warnAboutFrameMaxPriodBeingUsed(Frame frame) {
		if(frame.maxPeriod == null)
			return;
		warning('''The current implementation does not take this value in to account.''',frame,
			NodeCapabilityFilePackage.Literals.FRAME__MAX_PERIOD
		)
	}
	
	@Check
	def warnAboutFrameEventTriggeredBeingUsed(Frame frame) {
		if(frame.eventTriggeredFrame == null)
			return;
		warning('''The current implementation does not take this value in to account.''',frame,
			NodeCapabilityFilePackage.Literals.FRAME__EVENT_TRIGGERED_FRAME
		)
	}
	
	@Check
	def checkThatScalorSignalSizeIsInValidRange(Signal signal) {
		if(signal.initialValue instanceof ScalorSignalValue) {
			val v = Integer.decode(signal.size);
			if(v < 0 || v > 16) {
				error('''Invalid signal size "«signal.size»". The signal size must in the range [0,16].''',signal,
					NodeCapabilityFilePackage.Literals.SIGNAL__SIZE
				);
			}
		}
	}
	
	@Check
	def checkThatArraySignalSizeIsInValidRange(Signal signal) {
		if(signal.initialValue instanceof ArraySignalValue) {
			val v = Integer.decode(signal.size);
			if(v < 0 || v > 64) {
				error('''Invalid array signal size "«signal.size»". The signal size must in the range [0,64].''',signal,
					NodeCapabilityFilePackage.Literals.SIGNAL__SIZE
				);
			}
		}
	}
	
	@Check
	def checkThatArraySignalSizeIsMultipleOfEight(Signal signal) {
		if(signal.initialValue instanceof ArraySignalValue) {
			val v = Integer.decode(signal.size);
			if(v % 8 != 0) {
				error('''Invalid array signal size "«signal.size»". An array signal size must be a multiple of 8.''',signal,
					NodeCapabilityFilePackage.Literals.SIGNAL__SIZE
				);
			}
		}
	}
	
	@Check
	def checkThatArraySignalOffsetIsMultipleOfEight(Signal signal) {
		if(signal.initialValue instanceof ArraySignalValue) {
			val v = Integer.decode(signal.offset);
			if(v % 8 != 0) {
				error('''Invalid array signal offset "«signal.offset»". An array signal offset must be a multiple of 8.''',signal,
					NodeCapabilityFilePackage.Literals.SIGNAL__OFFSET
				);
			}
		}
	}
	
	@Check
	def checkThatAutomaticBitrateMinIsInTheRange1To20(AutomaticBitrate bitrate) {
		if(bitrate.minValue != null) {
			val v = Double.parseDouble(bitrate.minValue);
			if(v < 1 || v > 20) {
				error('''Invalid minimum bitrate "«bitrate.minValue»" kbps. Minimum bitrate must be in the range [1,20]kbps.''',bitrate,
					NodeCapabilityFilePackage.Literals.AUTOMATIC_BITRATE__MIN_VALUE
				);
			}
		}
	}
	
	@Check
	def checkThatAutomaticBitrateMaxIsInTheRange1To20(AutomaticBitrate bitrate) {
		if(bitrate.maxValue != null) {
			val v = Double.parseDouble(bitrate.maxValue);
			if(v < 1 || v > 20) {
				error('''Invalid maximum bitrate "«bitrate.maxValue»" kbps. Maximum bitrate must be in the range [1,20]kbps.''',bitrate,
					NodeCapabilityFilePackage.Literals.AUTOMATIC_BITRATE__MAX_VALUE
				);
			}
		}
	}
	
	@Check
	def checkThatAutomaticBitrateMinIsLessOrEqualToMax(AutomaticBitrate bitrate) {
		if(bitrate.minValue != null && bitrate.maxValue != null) {
			val min = Double.parseDouble(bitrate.minValue);
			val max = Double.parseDouble(bitrate.maxValue);
			if(min > max) {
				error('''Invalid minimum bitrate "«bitrate.minValue»" kbps greator than maximum bitrate "«bitrate.maxValue»" kbps.''',bitrate,
					NodeCapabilityFilePackage.Literals.AUTOMATIC_BITRATE__MIN_VALUE
				);
			}
		}
	}
	
	@Check
	def checkThatSelectBitratesAreInRange1to20(SelectBitrate bitrate) {
		bitrate.values.forEach[
			val v = Double.parseDouble(it);
			if(v < 1 || v > 20) {
				error('''Invalid bitrate "«it»" kbps. Bitrates must be in the range [1,20]kbps.''',bitrate,
					NodeCapabilityFilePackage.Literals.SELECT_BITRATE__VALUES,
					bitrate.values.indexOf(it)
				);
			}
		]
	}
	
	@Check
	def checkThatFixedBitrateIsInRange1To20(FixedBitrate bitrate) {
		val v = Double.parseDouble(bitrate.value);
		if(v < 1 || v > 20) {
			error('''Invalid bitrate "«bitrate.value»" kbps. Bitrates must be in the range [1,20]kbps.''',bitrate,
				NodeCapabilityFilePackage.Literals.FIXED_BITRATE__VALUE
			);
		}
	}
	
	@Check
	def checkThatThereAreNoDuplicatesInFaultStateSignals(Slave node) {
		val seen = new HashSet<Signal>();
		node.faultStateSignals.forEach [
			if(seen.contains(it)) {
				error('''Signal '«it.name»' is already in fault state signals.''', node,
					NodeCapabilityFilePackage.Literals.SLAVE__FAULT_STATE_SIGNALS,
					node.faultStateSignals.lastIndexOf(it))
			}
			seen.add(it);
		];
	}

	@Check
	def checkThatFrameNamesAreUniqueWithinANode(Node node) {
		val seen = new HashSet<String>();
		node.frames.forEach [
			if (seen.contains(it.name)) {
				error('''Frame '«it.name»' was already defined.''', it,
					NodeCapabilityFilePackage.Literals.FRAME__NAME
				)
			}
			seen.add(it.name);
		]
	}

	@Check
	def checkThatSignalNamesAreUniqueWithinANode(Node node) {
		val seen = new HashSet<String>();
		node.frames.forEach [
			it.signals.forEach [ signal |
				if (seen.contains(signal.name)) {
					error('''Signal '«signal.name»' was already defined.''', signal,
						NodeCapabilityFilePackage.Literals.SIGNAL__NAME)
				}
				seen.add(signal.name);
			]
		]
	}
	
	@Check
	def checkThatEencodingNamesAreUniqueWithinANode(Node node) {
		val seen = new HashSet<String>();
		node.encodings.forEach [
			if (seen.contains(it.name)) {
				error('''Encoding '«it.name»' was already defined.''', it,
					NodeCapabilityFilePackage.Literals.ENCODING__NAME)
			}
			seen.add(it.name);
		];
	}

	@Check
	def checkThatAllNadsInListAreValid(NadList list) {
		list.values.forEach[
			val v = Integer.decode(it);
			if(v < 0x01 || v > 0x7D) {
				error('''Invalid slave NAD address '«it»'. Slave NAD addresses must be in the range [0x01,0x7D]''',list,
				NodeCapabilityFilePackage.Literals.NAD_LIST__VALUES,
				list.values.indexOf(it));
			}
		]
	}

	@Check
	def checkThatMinNADInNadRangeIsValid(NadRange range) {
		val min = Integer.decode(range.minValue);
		if(min < 0x01 || min > 0x7D) {
			error('''Invalid minimum slave NAD address '«range.minValue»'. Slave NAD addresses must be in the range [0x01,0x7D]''',range,
			NodeCapabilityFilePackage.Literals.NAD_RANGE__MIN_VALUE);
		}
	}

	@Check
	def checkThatMaxNADInNadRangeIsValid(NadRange range) {
		val max = Integer.decode(range.maxValue);
		if(max < 0x01 || max > 0x7D) {
			error('''Invalid maximum slave NAD address '«range.maxValue»'. Slave NAD addresses must be in the range [0x01,0x7D]''',range,
			NodeCapabilityFilePackage.Literals.NAD_RANGE__MAX_VALUE);
		}
	}

	@Check
	def warnThatOnlyTheFirstNADInANadListWillBeUsedIfMoreThanOneIsListed(NadList list) {
		if(list.values.size != 1) {
			warning('''The current implementation does not support instance generation. The first value in the nad list will be used.''',list,
			NodeCapabilityFilePackage.Literals.NAD_LIST__VALUES);
		}
	}

	@Check
	def warnThatOnlyTheMinNADInANadRangeWillBeUsed(NadRange range) {
		warning('''The current implementation does not support instance generation. The minimum value in the nad range will be used.''',range,
		NodeCapabilityFilePackage.Literals.NAD_RANGE__MAX_VALUE);
	}

	// TODO add validations that check that subscribed frames,signals,and encodings match published frames,signals,and encodings.
}
	