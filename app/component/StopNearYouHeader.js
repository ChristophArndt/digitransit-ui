import React from 'react';
import PropTypes from 'prop-types';
import { Link } from 'found';
import { FormattedMessage } from 'react-intl';
import StopCode from './StopCode';
import ZoneIcon from './ZoneIcon';
import PlatformNumber from './PlatformNumber';
import { PREFIX_STOPS } from '../util/path';
import { isKeyboardSelectionEvent } from '../util/browser';

const StopNearYouHeader = ({ stop, color, desc, isStation }) => {
  const code = isStation ? <FormattedMessage id="station" /> : stop.code;
  return (
    <div className="stop-near-you-header-container">
      <div className="stop-header-content">
        <Link
          onClick={e => {
            e.stopPropagation();
          }}
          onKeyPress={e => {
            if (isKeyboardSelectionEvent(e)) {
              e.stopPropagation();
            }
          }}
          to={`/${PREFIX_STOPS}/${stop.gtfsId}`}
        >
          <h3 className="stop-near-you-name">
            {stop.name}
            <span className="sr-only">
              <PlatformNumber number={stop.platformCode} short={false} />
            </span>
          </h3>
        </Link>
        <div className="stop-near-you-info">
          <span className="stop-near-you-desc">{desc}</span>
          <StopCode code={code} />
          <PlatformNumber number={stop.platformCode} short />
          <ZoneIcon zoneId={stop.zoneId} zoneLabelColor={color} />
        </div>
      </div>
      <div className="stop-favourite-container" />
    </div>
  );
};

StopNearYouHeader.propTypes = {
  stop: PropTypes.object.isRequired,
  color: PropTypes.string,
  desc: PropTypes.string,
  isStation: PropTypes.bool,
};
StopNearYouHeader.defaultProps = {
  isStation: false,
};

export default StopNearYouHeader;
