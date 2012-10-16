#include "polyphonicsynth.h"

PolyphonicSynth::PolyphonicSynth(std::string synthName, sc::node_arg_list defaultArgs, int numberOfVoices, sc::Group *target,
                                 sc::AddAction addAction) :
    synthName(synthName),
    defaultArgs(defaultArgs),
    currentVoice(0),
    target(target),
    addAction(addAction)
{
    this->numberOfVoices = 0;
    setNumberOfVoices(numberOfVoices);
}

PolyphonicSynth::~PolyphonicSynth()
{
    for(int i = 0; i < synths.size(); ++i)
    {
        synths.at(i)->set("gate", 0);
        delete synths.at(i);
    }

    synths.clear();
}

void PolyphonicSynth::trigger(sc::node_arg_list args)
{
    currentVoice = (++currentVoice) % synths.size();
    args.push_back(sc::arg_pair("t_trig", 1));
    set(args);
}

void PolyphonicSynth::set(sc::node_arg_list& args)
{
    synths.at(currentVoice)->set(args);
}

int PolyphonicSynth::getNumberOfVoices()
{
    return numberOfVoices;
}

void PolyphonicSynth::setNumberOfVoices(int numberOfVoices)
{
    if(numberOfVoices <= 0)
    {
        std::cerr << "PolyphonicSynth: You can't set numberOfVoices to zero. Reassigned to 1." << std::endl;
    }

    else
    {
        int difference = numberOfVoices - this->numberOfVoices;

        if(difference < 0)
        {
            while(difference < 0 && synths.size() > 0)
            {
                synths.back()->set("gate", 0);
                delete synths.back();
                synths.pop_back();
                ++difference;
            }
        }

        else if(difference > 0)
        {
            while(difference > 0)
            {
                synths.push_back(new sc::Synth(synthName.c_str(), defaultArgs, sc::Server::internal));
                --difference;
            }
        }

        this->numberOfVoices = numberOfVoices;

        if(currentVoice >= numberOfVoices)
        {
            currentVoice = numberOfVoices - 1;
        }
    }
}
