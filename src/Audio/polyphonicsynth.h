#ifndef POLYPHONICSYNTH_H
#define POLYPHONICSYNTH_H

#include <string>
#include <vector>
#include "Node.h"

/**
*   @class PolyphicSynth A container that encapsulates a number of sc::Synth voices that take a t_trig and gate
*/
class PolyphonicSynth
{
public:

    /**
    *   @param std::string The name of the precompiled synthdef
    *   @param sc::node_arg_list The default list of arguments to be set on creation.
    *   @param int The maximum number of voices that can be active at the same time.
    *   @param sc::Group* the target group to add the synths too, default is sc::Server::internal->getDefaultGroup().
    *   @param sc::AddAction the add action (addToHead, addToTail, addBefore, addAfter, addReplace)
    */
    PolyphonicSynth(std::string synthName, sc::node_arg_list defaultArgs = sc::node_arg_list(), int numberOfVoices = 4,
                    sc::Group* target = sc::Server::internal->getDefaultGroup(), sc::AddAction addAction = sc::addToHead);

    /**
    *    Frees all the internal synths be setting gate to 0
    */
    ~PolyphonicSynth();

    /**
    *   Trigger one of the voices with a t_trig set to 1
    *   @param sc::node_arg_list The list of arguments to be set on trigger.
    */
    void trigger(sc::node_arg_list args = sc::node_arg_list());

    /**
    *   Sets the arguments fo the current voice
    *   @param sc::node_arg_list The list of arguments to be set on trigger.
    */
    void set(sc::node_arg_list& args);
    int getNumberOfVoices();
    void setNumberOfVoices(int numberOfVoices);

private:

    std::string synthName;
    int numberOfVoices;
    std::vector<sc::Synth*> synths;
    int currentVoice;
    sc::node_arg_list defaultArgs;
    sc::Group* target;
    sc::AddAction addAction;
};

#endif // POLYPHONICSYNTH_H
